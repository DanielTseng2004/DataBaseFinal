-- 下訂單交易範例
DELIMITER //
CREATE PROCEDURE PlaceOrder(
    IN p_CustomerID INT,
    IN p_ProductID INT,
    IN p_Quantity INT
)
BEGIN
    DECLARE v_UnitPrice DECIMAL(10,2);
    DECLARE v_Subtotal DECIMAL(10,2);
    DECLARE v_CurrentStock INT;
    DECLARE v_OrderID INT;
    
    DECLARE EXIT HANDLER FOR SQLEXCEPTION
    BEGIN
        ROLLBACK;
        RESIGNAL;
    END;
    
    START TRANSACTION;
    
    -- 檢查庫存
    SELECT CurrentStock, SalePrice INTO v_CurrentStock, v_UnitPrice
    FROM Products WHERE ProductID = p_ProductID FOR UPDATE;
    
    IF v_CurrentStock < p_Quantity THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = '庫存不足';
    END IF;
    
    -- 建立訂單
    INSERT INTO Orders (CustomerID, TotalAmount) VALUES (p_CustomerID, 0);
    SET v_OrderID = LAST_INSERT_ID();
    
    -- 計算小計
    SET v_Subtotal = v_UnitPrice * p_Quantity;
    
    -- 新增訂單明細
    INSERT INTO OrderDetails (OrderID, ProductID, Quantity, UnitPrice, Subtotal)
    VALUES (v_OrderID, p_ProductID, p_Quantity, v_UnitPrice, v_Subtotal);
    
    -- 更新訂單總額
    UPDATE Orders SET TotalAmount = v_Subtotal WHERE OrderID = v_OrderID;
    
    -- 更新庫存
    UPDATE Products SET CurrentStock = CurrentStock - p_Quantity
    WHERE ProductID = p_ProductID;
    
    -- 記錄庫存異動
    INSERT INTO InventoryRecords (ProductID, TransactionType, Quantity, StockAfter, Reference)
    VALUES (p_ProductID, 'sale', -p_Quantity, v_CurrentStock - p_Quantity, CONCAT('Order-', v_OrderID));
    
    COMMIT;
    SELECT v_OrderID as OrderID;
END //
DELIMITER ;

-- 庫存補貨建議
DELIMITER //
CREATE PROCEDURE GetRestockSuggestion()
BEGIN
    SELECT 
        p.ProductID,
        p.ProductName,
        p.CurrentStock,
        p.SafetyStock,
        COALESCE(AVG(ir.Quantity), 0) as AvgMonthlyUsage,
        GREATEST(
            p.SafetyStock * 2 - p.CurrentStock,
            COALESCE(AVG(ir.Quantity), 0) * 2
        ) as SuggestedOrderQty
    FROM Products p
    LEFT JOIN InventoryRecords ir ON p.ProductID = ir.ProductID
        AND ir.TransactionType = 'sale'
        AND ir.TransactionDate >= DATE_SUB(CURDATE(), INTERVAL 30 DAY)
    WHERE p.CurrentStock <= p.SafetyStock * 1.5
    GROUP BY p.ProductID, p.ProductName, p.CurrentStock, p.SafetyStock
    ORDER BY (p.CurrentStock / NULLIF(p.SafetyStock, 0));
END //
DELIMITER ;

-- 客戶價值分析函數
DELIMITER //
CREATE FUNCTION GetCustomerLevel(p_CustomerID INT) 
RETURNS VARCHAR(20)
READS SQL DATA
DETERMINISTIC
BEGIN
    DECLARE v_TotalPurchase DECIMAL(12,2);
    DECLARE v_Level VARCHAR(20);
    
    SELECT COALESCE(SUM(TotalAmount), 0) INTO v_TotalPurchase
    FROM Orders 
    WHERE CustomerID = p_CustomerID AND Status IN ('completed', 'shipped');
    
    IF v_TotalPurchase >= 100000 THEN
        SET v_Level = 'VIP';
    ELSEIF v_TotalPurchase >= 50000 THEN
        SET v_Level = 'Gold';
    ELSEIF v_TotalPurchase >= 20000 THEN
        SET v_Level = 'Silver';
    ELSE
        SET v_Level = 'Bronze';
    END IF;
    
    RETURN v_Level;
END //
DELIMITER ;

-- 自動更新訂單總額觸發器
DELIMITER //
CREATE TRIGGER UpdateOrderTotal
AFTER INSERT ON OrderDetails
FOR EACH ROW
BEGIN
    UPDATE Orders 
    SET TotalAmount = (
        SELECT SUM(Subtotal) 
        FROM OrderDetails 
        WHERE OrderID = NEW.OrderID
    )
    WHERE OrderID = NEW.OrderID;
END //
DELIMITER ;

-- 庫存異動記錄觸發器
DELIMITER //
CREATE TRIGGER LogInventoryChange
AFTER UPDATE ON Products
FOR EACH ROW
BEGIN
    IF OLD.CurrentStock != NEW.CurrentStock THEN
        INSERT INTO InventoryRecords (
            ProductID, 
            TransactionType, 
            Quantity, 
            StockAfter, 
            Reference
        ) VALUES (
            NEW.ProductID,
            'adjustment',
            NEW.CurrentStock - OLD.CurrentStock,
            NEW.CurrentStock,
            'Stock Adjustment'
        );
    END IF;
END //
DELIMITER ;

-- 防止庫存負數觸發器
DELIMITER //
CREATE TRIGGER PreventNegativeStock
BEFORE UPDATE ON Products
FOR EACH ROW
BEGIN
    IF NEW.CurrentStock < 0 THEN
        SIGNAL SQLSTATE '45000' 
        SET MESSAGE_TEXT = '庫存不能為負數';
    END IF;
END //
DELIMITER ;