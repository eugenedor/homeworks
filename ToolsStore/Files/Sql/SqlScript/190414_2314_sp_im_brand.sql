USE ToolsStore
GO

IF COL_LENGTH('dbo.CT_BRAND', 'DateLoad') IS NULL
BEGIN
  ALTER TABLE dbo.CT_BRAND
    ADD DateLoad datetime;
END
GO

IF EXISTS (SELECT * 
           FROM sys.objects 
		   WHERE type = 'P' 
		         AND name = 'SP_IM_BRAND')
DROP PROCEDURE SP_IM_BRAND;
GO

CREATE PROCEDURE dbo.SP_IM_BRAND
	@Code     NVARCHAR(100),
	@Name     NVARCHAR(500)
AS
BEGIN
	DECLARE @tempMessage NVARCHAR(MAX) = NULL,
	        @DateCur	 DATETIME;

	SET @DateCur = GETDATE();

	IF (NULLIF(LTRIM(RTRIM(@Code)), '') IS NULL)
	BEGIN
		SET @tempMessage = 'Код - пустое значение'
		RAISERROR (@tempMessage , 16, 1) 
		RETURN(0)
	END

	UPDATE CT_BRAND
	SET Name     = @Name,
	    DateLoad = @DateCur
	WHERE CT_BRAND.Code = @Code;

	INSERT INTO CT_BRAND(Code, Name, DateLoad)
	SELECT im.Code, im.Name AS Name, im.DateLoad
	FROM (SELECT @Code AS Code, @Name AS Name, @DateCur AS DateLoad) im 
	     LEFT JOIN CT_BRAND b 
		   ON im.Code = b.Code
	WHERE b.BrandId IS NULL
		AND im.Code IS NOT NULL
END
GO