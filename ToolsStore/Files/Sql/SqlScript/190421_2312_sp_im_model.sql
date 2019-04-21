USE ToolsStore
GO

IF COL_LENGTH('dbo.SK_MODEL', 'DateLoad') IS NULL
BEGIN
  ALTER TABLE dbo.SK_MODEL
    ADD DateLoad datetime;
END
GO

IF EXISTS (SELECT * 
           FROM sys.objects 
		   WHERE type = 'P' 
		         AND name = 'SP_IM_MODEL')
DROP PROCEDURE SP_IM_MODEL;
GO