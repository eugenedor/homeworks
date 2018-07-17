--
--Add column FileName to table CT_CATEGORY
--
ALTER TABLE dbo.CT_CATEGORY
	ADD FileName nvarchar(100) NULL;

--
--Add column DateLoad to table CT_CATEGORY
--
ALTER TABLE dbo.CT_CATEGORY
	ADD DateLoad datetime NULL;