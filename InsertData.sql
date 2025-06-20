-- 插入客戶資料
INSERT INTO Customers (CustomerName, Phone, Address, Email) VALUES
('台北科技有限公司', '02-1234-5678', '台北市信義區信義路100號', 'info@taipei-tech.com'),
('新竹電子股份有限公司', '03-2345-6789', '新竹市東區光復路200號', 'contact@hsinchu-elec.com'),
('高雄貿易商行', '07-3456-7890', '高雄市前鎮區中山路300號', 'sales@kaohsiung-trade.com'),
('台中製造業', '04-4567-8901', '台中市西屯區台灣大道400號', 'order@taichung-mfg.com'),
('桃園物流公司', '03-5678-9012', '桃園市中壢區中正路500號', 'logistics@taoyuan.com'),
('基隆港務局', '02-6789-0123', '基隆市仁愛區港西街600號', 'port@keelung.gov.tw'),
('宜蘭農產合作社', '03-7890-1234', '宜蘭市中山路700號', 'coop@yilan-agri.org'),
('花蓮觀光飯店', '03-8901-2345', '花蓮市中華路800號', 'hotel@hualien-tour.com'),
('台東特產行', '089-012-345', '台東市中華路900號', 'specialty@taitung.com'),
('澎湖海鮮餐廳', '06-9123-456', '澎湖縣馬公市中正路1000號', 'seafood@penghu.com');

-- 插入供應商資料
INSERT INTO Suppliers (SupplierName, ContactPerson, Phone, Address) VALUES
('東亞電子材料', '李經理', '02-1111-2222', '台北市內湖區科技路1號'),
('南方機械設備', '王總監', '06-3333-4444', '台南市安南區工業路2號'),
('中部零件供應', '陳主任', '04-5555-6666', '台中市大雅區中科路3號'),
('北區工具商行', '張老闆', '03-7777-8888', '桃園市龜山區工業一路4號'),
('西南塑膠原料', '劉經理', '07-9999-0000', '高雄市楠梓區加工區路5號'),
('東部金屬加工', '黃廠長', '03-1234-5678', '花蓮市工業區建國路6號'),
('離島物資供應', '吳經理', '06-8765-4321', '澎湖縣馬公市工業路7號'),
('山區建材行', '林老闆', '049-111-222', '南投縣埔里鎮中山路8號'),
('海岸線漁具', '蔡經理', '089-333-444', '台東縣成功鎮港口路9號'),
('國際貿易公司', '鄭總經理', '02-5555-7777', '台北市松山區敦化北路10號');

-- 插入產品資料
INSERT INTO Products (ProductName, Specification, SalePrice, SafetyStock, CurrentStock) VALUES
('筆記型電腦', 'Intel i7, 16GB RAM, 512GB SSD', 35000.00, 10, 25),
('無線滑鼠', '2.4GHz無線, 1600DPI', 890.00, 50, 120),
('機械鍵盤', '青軸, RGB背光', 2500.00, 20, 45),
('27吋顯示器', '4K解析度, IPS面板', 12000.00, 5, 15),
('藍牙耳機', '主動降噪, 30小時續航', 4500.00, 30, 60),
('行動電源', '20000mAh, 快充PD', 1200.00, 40, 80),
('手機保護殼', '透明矽膠材質', 350.00, 100, 200),
('USB充電線', 'Type-C, 1.5米', 250.00, 80, 150),
('桌上型風扇', '12吋, 三段風速', 1800.00, 15, 35),
('LED檯燈', '護眼光源, 觸控調光', 2200.00, 25, 50);

-- 插入訂單資料
INSERT INTO Orders (CustomerID, OrderDate, TotalAmount, Status) VALUES
(1, '2025-06-01 10:30:00', 37890.00, 'completed'),
(2, '2025-06-02 14:15:00', 15000.00, 'completed'),
(3, '2025-06-03 09:45:00', 8750.00, 'shipped'),
(4, '2025-06-04 16:20:00', 25600.00, 'confirmed'),
(5, '2025-06-05 11:10:00', 6800.00, 'pending'),
(1, '2025-06-10 13:30:00', 48000.00, 'completed'),
(3, '2025-06-12 15:45:00', 12350.00, 'shipped'),
(6, '2025-06-14 10:20:00', 5400.00, 'confirmed'),
(7, '2025-06-15 12:30:00', 8900.00, 'pending'),
(2, '2025-06-16 14:50:00', 22000.00, 'confirmed');

-- 插入訂單明細資料
INSERT INTO OrderDetails (OrderID, ProductID, Quantity, UnitPrice, Subtotal) VALUES
(1, 1, 1, 35000.00, 35000.00),
(1, 2, 3, 890.00, 2670.00),
(1, 8, 1, 250.00, 250.00),
(2, 4, 1, 12000.00, 12000.00),
(2, 5, 2, 1500.00, 3000.00),
(3, 3, 2, 2500.00, 5000.00),
(3, 6, 3, 1200.00, 3600.00),
(3, 7, 5, 350.00, 1750.00),
(4, 1, 1, 35000.00, 35000.00),
(4, 9, 5, 1800.00, 9000.00),
(5, 10, 3, 2200.00, 6600.00),
(5, 8, 2, 250.00, 500.00),
(6, 4, 4, 12000.00, 48000.00),
(7, 5, 3, 4500.00, 13500.00),
(8, 2, 6, 890.00, 5340.00),
(9, 3, 3, 2500.00, 7500.00),
(9, 7, 4, 350.00, 1400.00),
(10, 1, 1, 35000.00, 35000.00);

-- 插入進貨紀錄資料
INSERT INTO PurchaseRecords (SupplierID, ProductID, PurchaseDate, Quantity, PurchasePrice) VALUES
(1, 1, '2025-05-15 09:00:00', 10, 28000.00),
(2, 2, '2025-05-16 10:30:00', 50, 650.00),
(3, 3, '2025-05-17 14:20:00', 20, 1800.00),
(1, 4, '2025-05-18 11:45:00', 8, 9500.00),
(4, 5, '2025-05-19 13:15:00', 30, 3200.00),
(5, 6, '2025-05-20 15:30:00', 40, 850.00),
(2, 7, '2025-05-21 08:45:00', 100, 250.00),
(6, 8, '2025-05-22 10:15:00', 80, 180.00),
(3, 9, '2025-05-23 12:00:00', 25, 1300.00),
(4, 10, '2025-05-24 16:30:00', 35, 1600.00);

-- 插入庫存紀錄資料  
INSERT INTO InventoryRecords (ProductID, TransactionType, Quantity, StockAfter, TransactionDate, Reference) VALUES
(1, 'purchase', 10, 10, '2025-05-15 09:00:00', 'PO-001'),
(2, 'purchase', 50, 50, '2025-05-16 10:30:00', 'PO-002'),
(3, 'purchase', 20, 20, '2025-05-17 14:20:00', 'PO-003'),
(1, 'sale', -1, 9, '2025-06-01 10:30:00', 'Order-1'),
(2, 'sale', -3, 47, '2025-06-01 10:30:00', 'Order-1'),
(4, 'purchase', 8, 8, '2025-05-18 11:45:00', 'PO-004'),
(4, 'sale', -1, 7, '2025-06-02 14:15:00', 'Order-2'),
(5, 'purchase', 30, 30, '2025-05-19 13:15:00', 'PO-005'),
(5, 'sale', -2, 28, '2025-06-02 14:15:00', 'Order-2'),
(3, 'sale', -2, 18, '2025-06-03 09:45:00', 'Order-3');