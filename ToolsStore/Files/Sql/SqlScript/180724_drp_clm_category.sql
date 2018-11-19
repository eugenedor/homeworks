--
--Drop column FileName from table CT_CATEGORY
--
ALTER TABLE CT_CATEGORY
  DROP COLUMN FILENAME;

--
--Add column DateLoad to table CT_VAT
--
ALTER TABLE dbo.CT_VAT
	ADD DateLoad datetime NULL;