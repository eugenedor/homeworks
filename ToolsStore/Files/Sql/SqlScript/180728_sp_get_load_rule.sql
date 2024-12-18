USE ToolsStore
GO

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE dbo.SP_GET_LOAD_RULE
	@Path     nvarchar(1000)
AS
BEGIN
	SELECT LoadRuleId, 
	       Code, 
		   FileName, 
		   IsActive, 
		   MethodLoad, 
		   isnull(@Path + '\', '') + PathToXsd + '\' as PathToXsd, 
		   XsdName, 
		   Descr, 
		   Ord
	FROM dbo.MT_LOAD_RULE
END