-- 月銷售報表視圖
CREATE VIEW MonthlySales AS
SELECT 
    YEAR(o.OrderDate) as SalesYear,
    MONTH(o.OrderDate) as SalesMonth,
    COUNT(DISTINCT o.OrderID) as OrderCount,
    SUM(o.TotalAmount) as TotalSales,
    AVG(o.TotalAmount) as AvgOrderValue
FROM Orders o
WHERE o.Status IN ('completed', 'shipped')
GROUP BY YEAR(o.OrderDate), MONTH(o.OrderDate);

-- 庫存安全量警示視圖
CREATE VIEW LowStockAlert AS
SELECT 
    p.ProductID,
    p.ProductName,
    p.CurrentStock,
    p.SafetyStock,
    (p.CurrentStock - p.SafetyStock) as StockDifference,
    CASE 
        WHEN p.CurrentStock <= p.SafetyStock THEN '緊急補貨'
        WHEN p.CurrentStock <= p.SafetyStock * 1.2 THEN '需要關注'
        ELSE '安全'
    END as StockStatus
FROM Products p
WHERE p.CurrentStock <= p.SafetyStock * 1.2;

-- 客戶訂單分析視圖
CREATE VIEW CustomerAnalysis AS
SELECT 
    c.CustomerID,
    c.CustomerName,
    COUNT(o.OrderID) as OrderCount,
    SUM(o.TotalAmount) as TotalPurchase,
    AVG(o.TotalAmount) as AvgOrderValue,
    MAX(o.OrderDate) as LastOrderDate,
    DATEDIFF(CURDATE(), MAX(o.OrderDate)) as DaysSinceLastOrder
FROM Customers c
LEFT JOIN Orders o ON c.CustomerID = o.CustomerID
WHERE o.Status IN ('completed', 'shipped')
GROUP BY c.CustomerID, c.CustomerName;