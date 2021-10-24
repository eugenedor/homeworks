USE master;  
GO 
 
IF DB_ID (N'SportsStore') IS NOT NULL
	DROP DATABASE SportsStore;
GO

CREATE DATABASE SportsStore
ON 
( NAME = SportsStore,
    FILENAME = 'E:\SelfEducation\Databases\SportsStore.mdf',
    SIZE = 10,
    MAXSIZE = 50,
    FILEGROWTH = 5 )
LOG ON
( NAME = SportsStore_log,
    FILENAME = 'E:\SelfEducation\Databases\SportsStore_log.ldf',
    SIZE = 5MB,
    MAXSIZE = 25MB,
    FILEGROWTH = 5MB ) ;
GO


-- Verify the database files and sizes  
SELECT name, size, size*1.0/128 AS [Size in MBs]   
FROM sys.master_files  
WHERE name = N'SportsStore';  
GO

USE SportsStore;  
GO 

CREATE TABLE Products
(
	[ProductID] INT IDENTITY(1,1) NOT NULL,
	[Name] NVARCHAR(100) NOT NULL,
	[Description] NVARCHAR(500) NOT NULL,
	[Category] NVARCHAR(50) NOT NULL,
	[Price] DECIMAL(16, 2) NOT NULL
 CONSTRAINT [PK_PRODUCTS] PRIMARY KEY CLUSTERED 
(
	[ProductID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY];
GO

INSERT INTO PRODUCTS (NAME, DESCRIPTION, CATEGORY, PRICE)
VALUES ('Kayak', 'A boat for one person', 'Watersports', 275.00);
INSERT INTO PRODUCTS (NAME, DESCRIPTION, CATEGORY, PRICE)
VALUES ('Lifejacket', 'Protective and fachionable', 'Watersports', 48.95);
INSERT INTO PRODUCTS (NAME, DESCRIPTION, CATEGORY, PRICE)
VALUES ('Soccer Ball', 'FIFA-approved size and weight', 'Soccer', 19.50);
INSERT INTO PRODUCTS (NAME, DESCRIPTION, CATEGORY, PRICE)
VALUES ('Corner Flags', 'Give your playing field a professional touch', 'Soccer', 34.95);
INSERT INTO PRODUCTS (NAME, DESCRIPTION, CATEGORY, PRICE)
VALUES ('Stadium', 'Flat-packet 35,000-seat stadium', 'Soccer', 79500.00);
INSERT INTO PRODUCTS (NAME, DESCRIPTION, CATEGORY, PRICE)
VALUES ('Thinking Cap', 'Improve your brain efficiency by 75%', 'Chess', 16.00);
INSERT INTO PRODUCTS (NAME, DESCRIPTION, CATEGORY, PRICE)
VALUES ('Unsteady Chair', 'Secretly give your opponent a disadvantage', 'Chess', 29.95);
INSERT INTO PRODUCTS (NAME, DESCRIPTION, CATEGORY, PRICE)
VALUES ('Human chess board', 'A fun game for the family', 'Chess', 75.00);
INSERT INTO PRODUCTS (NAME, DESCRIPTION, CATEGORY, PRICE)
VALUES ('Bling-Bling King', 'Gold-plated, diamond-studded King', 'Chess', 1200.00);


select p.ProductID, p.Name, p.Description, p.Category, p.Price
from Products p;