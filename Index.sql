-- 為常用查詢欄位建立索引
CREATE INDEX idx_orders_customer_date ON Orders(CustomerID, OrderDate);
CREATE INDEX idx_orderdetails_product ON OrderDetails(ProductID);
CREATE INDEX idx_inventory_product_date ON InventoryRecords(ProductID, TransactionDate);
CREATE INDEX idx_purchase_supplier_date ON PurchaseRecords(SupplierID, PurchaseDate);
CREATE INDEX idx_products_stock ON Products(CurrentStock, SafetyStock);