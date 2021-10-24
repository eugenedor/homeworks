USE SportsStore;

--
--add columns
--
ALTER TABLE dbo.Products ADD ImageData VARBINARY(MAX) NULL;
GO

ALTER TABLE dbo.Products ADD ImageMimeType VARCHAR(50) NULL;
GO

ALTER TABLE dbo.Products ADD ImageName VARCHAR(300) NULL;
GO


----
----drop columns
----
--ALTER TABLE dbo.Products DROP COLUMN ImageData;
--GO

--ALTER TABLE dbo.Products DROP COLUMN ImageMimeType ;
--GO

--ALTER TABLE dbo.Products DROP COLUMN ImageName ;
--GO

select * from dbo.Products p order by p.ProductID asc;