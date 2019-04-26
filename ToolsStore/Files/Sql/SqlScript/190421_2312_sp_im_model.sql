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

CREATE PROCEDURE dbo.SP_IM_MODEL
	@Code     BIGINT,
	@Name     NVARCHAR(500),
	@Brand    NVARCHAR(100)
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

	IF (NULLIF(LTRIM(RTRIM(@Brand)), '') IS NULL)
	BEGIN
		SET @tempMessage = 'Код брэнда - пустое значение'
		RAISERROR (@tempMessage , 16, 1) 
		RETURN(0)
	END

	IF (NOT EXISTS (SELECT BrandId
				    FROM CT_BRAND
				    WHERE Code = @Brand))
	BEGIN
		SET @tempMessage = 'В БД отсутствует брэнд: ' + @Brand
		RAISERROR (@tempMessage , 16, 1) 
		RETURN(0)
	END

	UPDATE SK_MODEL
	SET Name = @Name,
	    DateLoad = @DateCur,
		BrandId = (SELECT DISTINCT BrandId FROM CT_BRAND WHERE Code = @Brand)
	WHERE Code = @Code;

	INSERT INTO SK_MODEL(Code, Name, BrandId, DateLoad)
	SELECT im.Code, im.Name, im.BrandId, im.DateLoad
	FROM (SELECT @Code AS Code, 
	             @Name AS Name,  
				 (SELECT DISTINCT BrandId FROM CT_BRAND WHERE Code = @Brand) AS BrandId,
				 @DateCur AS DateLoad) im 
	     LEFT JOIN SK_MODEL m
		   ON im.Code = m.Code
	WHERE m.ModelId IS NULL
END