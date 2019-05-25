USE ToolsStore;
GO

--
-- ������� ������ � ������� dbo.CT_BRAND
--
SET IDENTITY_INSERT dbo.MT_LOAD_RULE ON
GO

INSERT INTO dbo.MT_LOAD_RULE (LoadRuleId, Code, Pattern, Method, Descr, IsActive, Ord)
VALUES (4, 'Model', 'Model.xml', 'LoadModel', '������', 1, 4);
GO

SET IDENTITY_INSERT dbo.MT_LOAD_RULE OFF
GO

DBCC CHECKIDENT('dbo.MT_LOAD_RULE', RESEED, 4) WITH NO_INFOMSGS
GO