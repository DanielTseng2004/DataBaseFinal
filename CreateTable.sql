-- 建立資料庫
CREATE DATABASE OrderInventorySystem;
USE OrderInventorySystem;

-- 客戶表
CREATE TABLE Customers (
    CustomerID INT PRIMARY KEY AUTO_INCREMENT,
    CustomerName VARCHAR(100) NOT NULL,
    Phone VARCHAR(20),
    Address TEXT,
    Email VARCHAR(100),
    CreatedDate DATETIME DEFAULT CURRENT_TIMESTAMP
);

-- 供應商表
CREATE TABLE Suppliers (
    SupplierID INT PRIMARY KEY AUTO_INCREMENT,
    SupplierName VARCHAR(100) NOT NULL,
    ContactPerson VARCHAR(50),
    Phone VARCHAR(20),
    Address TEXT,
    CreatedDate DATETIME DEFAULT CURRENT_TIMESTAMP
);

-- 產品表
CREATE TABLE Products (
    ProductID INT PRIMARY KEY AUTO_INCREMENT,
    ProductName VARCHAR(100) NOT NULL,
    Specification VARCHAR(200),
    SalePrice DECIMAL(10,2) NOT NULL,
    SafetyStock INT DEFAULT 0,
    CurrentStock INT DEFAULT 0,
    CreatedDate DATETIME DEFAULT CURRENT_TIMESTAMP
);

-- 訂單表
CREATE TABLE Orders (
    OrderID INT PRIMARY KEY AUTO_INCREMENT,
    CustomerID INT NOT NULL,
    OrderDate DATETIME DEFAULT CURRENT_TIMESTAMP,
    TotalAmount DECIMAL(12,2) DEFAULT 0,
    Status ENUM('pending', 'confirmed', 'shipped', 'completed', 'cancelled') DEFAULT 'pending',
    FOREIGN KEY (CustomerID) REFERENCES Customers(CustomerID)
);

-- 訂單明細表
CREATE TABLE OrderDetails (
    OrderID INT,
    ProductID INT,
    Quantity INT NOT NULL,
    UnitPrice DECIMAL(10,2) NOT NULL,
    Subtotal DECIMAL(10,2) NOT NULL,
    PRIMARY KEY (OrderID, ProductID),
    FOREIGN KEY (OrderID) REFERENCES Orders(OrderID),
    FOREIGN KEY (ProductID) REFERENCES Products(ProductID)
);

-- 進貨紀錄表
CREATE TABLE PurchaseRecords (
    PurchaseID INT PRIMARY KEY AUTO_INCREMENT,
    SupplierID INT NOT NULL,
    ProductID INT NOT NULL,
    PurchaseDate DATETIME DEFAULT CURRENT_TIMESTAMP,
    Quantity INT NOT NULL,
    PurchasePrice DECIMAL(10,2) NOT NULL,
    FOREIGN KEY (SupplierID) REFERENCES Suppliers(SupplierID),
    FOREIGN KEY (ProductID) REFERENCES Products(ProductID)
);

-- 庫存紀錄表
CREATE TABLE InventoryRecords (
    RecordID INT PRIMARY KEY AUTO_INCREMENT,
    ProductID INT NOT NULL,
    TransactionType ENUM('purchase', 'sale', 'adjustment') NOT NULL,
    Quantity INT NOT NULL,
    StockAfter INT NOT NULL,
    TransactionDate DATETIME DEFAULT CURRENT_TIMESTAMP,
    Reference VARCHAR(100),
    FOREIGN KEY (ProductID) REFERENCES Products(ProductID)
);