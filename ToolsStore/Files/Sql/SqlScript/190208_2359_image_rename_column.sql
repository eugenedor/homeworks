USE ToolsStore;
GO

EXEC sp_rename 'dbo.CT_IMAGE.Name', 'FileName', 'COLUMN'; 