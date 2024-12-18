USE ToolsStore
GO

ALTER PROCEDURE dbo.SP_IM_CATEGORY
	@Code     NVARCHAR(100),
	@Name     NVARCHAR(250),
	@Ord      INT            = NULL
AS
BEGIN
	DECLARE @tempMessage NVARCHAR(MAX) = NULL

	IF (NULLIF(@Code, '') IS NULL)
	BEGIN
		SET @tempMessage = 'Код - пустое значение'
		RAISERROR (@tempMessage , 16, 1) 
		RETURN(0)
	END

	MERGE dbo.CT_CATEGORY AS target
	USING (SELECT @Code, @Name, @Ord, getdate()) AS source (Code, Name, Ord, DateLoad)
	ON (target.code = source.code)
	WHEN MATCHED THEN
		UPDATE SET Name       = source.Name,
				   Ord        = source.Ord,
				   DateLoad   = source.DateLoad
	WHEN NOT MATCHED THEN
		INSERT (Code, Name, Ord, DateLoad)
		VALUES (source.Code, source.Name, source.Ord, source.DateLoad);

END
GO

ALTER PROCEDURE dbo.SP_IM_VAT
	@Code     INT,
	@Name     NVARCHAR(100),
	@IsActive BIT           = NULL
AS
BEGIN
	DECLARE @tempMessage NVARCHAR(MAX) = NULL

	IF (@Code IS NULL)
	BEGIN
		SET @tempMessage = 'Код - пустое значение'
		RAISERROR (@tempMessage , 16, 1) 
		RETURN(0)
	END

	MERGE dbo.CT_VAT AS target
	USING (SELECT @Code, @Name, @IsActive, getdate()) AS source (Code, Name, IsActive, DateLoad)
	ON (target.Code = source.Code)
	WHEN MATCHED THEN
		UPDATE SET Name     = source.Name,
				   IsActive = source.IsActive,
				   DateLoad = source.DateLoad
	WHEN NOT MATCHED THEN
		INSERT (Code, Name, IsActive, DateLoad)
		VALUES (source.Code, source.Name, source.IsActive, source.DateLoad);

END
GO
