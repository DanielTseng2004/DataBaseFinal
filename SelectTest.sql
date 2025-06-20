-- 1. 月銷售查詢
SELECT * FROM MonthlyS;

-- 2. 庫存安全量查詢
SELECT * FROM LowStockAlert;


-- 3. 產品銷售排行
SELECT 
    p.ProductName,
    SUM(od.Quantity) as TotalSold,
    SUM(od.Subtotal) as TotalRevenue,
    AVG(od.UnitPrice) as AvgPrice
FROM Products p
JOIN OrderDetails od ON p.ProductID = od.ProductID
JOIN Orders o ON od.OrderID = o.OrderID
WHERE o.Status IN ('completed', 'shipped')
GROUP BY p.ProductID, p.ProductName
ORDER BY TotalRevenue DESC;

-- 4. 供應商採購分析
SELECT 
    s.SupplierName,
    COUNT(pr.PurchaseID) as PurchaseCount,
    SUM(pr.Quantity * pr.PurchasePrice) as TotalPurchaseValue,
    AVG(pr.PurchasePrice) as AvgUnitCost
FROM Suppliers s
JOIN PurchaseRecords pr ON s.SupplierID = pr.SupplierID
GROUP BY s.SupplierID, s.SupplierName
ORDER BY TotalPurchaseValue DESC;