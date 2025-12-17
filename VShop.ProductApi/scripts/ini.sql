-- 1. Create db
IF NOT EXISTS (SELECT name FROM sys.databases WHERE name = N'VShopDB')
BEGIN
    CREATE DATABASE VShopDB;
END
GO

USE VShopDB;
GO

-- 2. Create table
IF NOT EXISTS (SELECT * FROM sys.tables WHERE name = 'Categories')
BEGIN
    CREATE TABLE Categories
    (
        CategoryId INT IDENTITY(1,1) PRIMARY KEY,
        Name NVARCHAR(100) NOT NULL
    );
END
GO

-- 3. Create table
IF NOT EXISTS (SELECT * FROM sys.tables WHERE name = 'Products')
BEGIN
    CREATE TABLE Products
    (
        Id INT IDENTITY(1,1) PRIMARY KEY,
        Name NVARCHAR(100) NOT NULL,
        Price DECIMAL(12,2) NOT NULL,
        Description NVARCHAR(255) NOT NULL,
        Stock BIGINT NOT NULL,
        ImageURL NVARCHAR(255) NOT NULL,
        CategoryId INT NOT NULL,
        CONSTRAINT FK_Products_Categories FOREIGN KEY (CategoryId)
            REFERENCES Categories(CategoryId) ON DELETE CASCADE
    );
END
GO

-- 4. Seed data
IF NOT EXISTS (SELECT * FROM Categories)
BEGIN
    INSERT INTO Categories (Name) VALUES ('Scholar objects'), ('Accessories');
END
GO

IF NOT EXISTS (SELECT * FROM Products)
BEGIN
    INSERT INTO Products (Name, Price, Description, Stock, ImageURL, CategoryId)
    VALUES 
        ('notebook', 7.55, 'notebook', 10, 'notebook.jpg', 1),
        ('pencil', 3.45, 'black pencil', 20, 'pencil1.jpg', 1),
        ('clips', 5.33, 'clips for paper', 50, 'clips1.jpg', 2);
END
GO
