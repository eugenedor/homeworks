USE [ToolsStore]
GO

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[SP_IM_CATEGORY]
	@code     nvarchar(100),
	@name     nvarchar(250),
	@ord      int            = null,
	@filename nvarchar(100)  = null
AS
BEGIN
	DECLARE @tempMessage NVARCHAR(MAX) = NULL

	IF (NULLIF(@code, '') IS NULL)
	BEGIN
		SET @tempMessage = 'Код - пустое значение'
		RAISERROR (@tempMessage , 16, 1) 
		RETURN(0)
	END

	MERGE dbo.CT_CATEGORY AS target
	USING (SELECT @code, @name, @ord, @filename, getdate()) AS source (Code, Name, Ord, Flname, DateLoad)
	ON (target.code = source.code)
	WHEN MATCHED THEN
		UPDATE SET Name       = source.Name,
				   Ord        = source.Ord,
				   [FileName] = source.Flname,
				   DateLoad   = source.DateLoad
	WHEN NOT MATCHED THEN
		INSERT (Code, Name, Ord, [FileName], DateLoad)
		VALUES (source.Code, source.Name, source.Ord, source.Flname, source.DateLoad);

END