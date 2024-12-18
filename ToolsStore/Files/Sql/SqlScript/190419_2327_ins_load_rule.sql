USE ToolsStore;
GO

--
-- Вставка данных в таблицу dbo.CT_BRAND
--
SET IDENTITY_INSERT dbo.MT_LOAD_RULE ON
GO

INSERT INTO dbo.MT_LOAD_RULE (LoadRuleId, Code, Pattern, Method, Descr, IsActive, Ord)
VALUES (3, 'Brand', 'Brand.xml', 'LoadBrand', 'Брэнд', 1, 3);
GO

SET IDENTITY_INSERT dbo.MT_LOAD_RULE OFF
GO

DBCC CHECKIDENT('dbo.MT_LOAD_RULE', RESEED, 3) WITH NO_INFOMSGS
GO