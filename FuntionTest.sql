--資料一致性測試
-- 測試外鍵約束
-- 這個會失敗，因為不存在CustomerID = 999
INSERT INTO Orders (CustomerID, TotalAmount) VALUES (999, 1000.00);

-- 測試交易回滾
START TRANSACTION;
UPDATE Products SET CurrentStock = CurrentStock - 100 WHERE ProductID = 1;
-- 檢查是否會觸發負數限制
SELECT CurrentStock FROM Products WHERE ProductID = 1;
ROLLBACK;
--------------------------------------------------------------------------------------------------

--效能測試
-- 測試索引效果 - 查詢執行計劃
EXPLAIN SELECT * FROM Orders WHERE CustomerID = 1 AND OrderDate >= '2025-06-01';

-- 查詢沒有索引的情況（移除索引後比較）
-- DROP INDEX idx_orders_customer_date ON Orders;
-- EXPLAIN SELECT * FROM Orders WHERE CustomerID = 1 AND OrderDate >= '2025-06-01';

-- 查詢優化範例
SELECT SQL_NO_CACHE COUNT(*) FROM Orders o 
JOIN OrderDetails od ON o.OrderID = od.OrderID 
WHERE o.OrderDate >= '2025-06-01';
--------------------------------------------------------------------------------------------------

--功能演示
-- 執行庫存補貨建議
CALL GetRestockSuggestion();

-- 查看月銷售報表
SELECT * FROM MonthlyS ORDER BY SalesYear DESC, SalesMonth DESC;

-- 查看庫存警示
SELECT * FROM LowStockAlert;

-- 測試下訂單程序
CALL PlaceOrder(1, 2, 5);

