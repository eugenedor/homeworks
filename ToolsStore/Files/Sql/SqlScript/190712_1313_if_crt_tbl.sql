USE ToolsStore
GO

IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[TempTbl]') AND type in (N'U'))
BEGIN
	--CREATE TABLE [dbo].[TempTbl]
END

GO