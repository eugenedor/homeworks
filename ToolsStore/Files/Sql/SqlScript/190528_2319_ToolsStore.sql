SET CONCAT_NULL_YIELDS_NULL, ANSI_NULLS, ANSI_PADDING, QUOTED_IDENTIFIER, ANSI_WARNINGS, ARITHABORT, XACT_ABORT ON
SET NUMERIC_ROUNDABORT, IMPLICIT_TRANSACTIONS OFF
GO

USE ToolsStore2
GO

IF DB_NAME() <> N'ToolsStore2' SET NOEXEC ON
GO


--
-- Изменить уровень локализации транзакции
--
SET TRANSACTION ISOLATION LEVEL SERIALIZABLE
GO

--
-- Начать транзакцию
--
BEGIN TRANSACTION
GO

--
-- Создать таблицу [dbo].[RS_ORDER]
--
CREATE TABLE [dbo].[RS_ORDER] (
  [OrderId] [bigint] IDENTITY,
  [Surname] [nvarchar](100) NOT NULL,
  [Name] [nvarchar](100) NOT NULL,
  [Phone] [nvarchar](50) NOT NULL,
  [Email] [nvarchar](50) NULL,
  [Line1] [nvarchar](250) NOT NULL,
  [Line2] [nvarchar](150) NULL,
  [Line3] [nvarchar](150) NULL,
  [City] [nvarchar](100) NOT NULL,
  [State] [nvarchar](100) NOT NULL,
  [Zip] [nvarchar](50) NULL,
  [Country] [nvarchar](100) NOT NULL,
  [GiftWrap] [bit] NOT NULL,
  [DateOrder] [datetime] NULL,
  CONSTRAINT [PK_RS_ORDER] PRIMARY KEY CLUSTERED ([OrderId])
)
ON [PRIMARY]
GO
IF @@ERROR<>0 OR @@TRANCOUNT=0 BEGIN IF @@TRANCOUNT>0 ROLLBACK SET NOEXEC ON END
GO

--
-- Создать таблицу [dbo].[MT_SETTING]
--
CREATE TABLE [dbo].[MT_SETTING] (
  [SettingId] [bigint] IDENTITY,
  [Code] [nvarchar](50) NOT NULL,
  [Value] [nvarchar](250) NOT NULL,
  [Descr] [nvarchar](250) NOT NULL,
  [IsActive] [bit] NOT NULL,
  CONSTRAINT [PK_MT_SETTING] PRIMARY KEY CLUSTERED ([SettingId])
)
ON [PRIMARY]
GO
IF @@ERROR<>0 OR @@TRANCOUNT=0 BEGIN IF @@TRANCOUNT>0 ROLLBACK SET NOEXEC ON END
GO

--
-- Создать индекс [AK_MT_SETTING] для объекта типа таблица [dbo].[MT_SETTING]
--
CREATE UNIQUE INDEX [AK_MT_SETTING]
  ON [dbo].[MT_SETTING] ([Code])
  ON [PRIMARY]
GO
IF @@ERROR<>0 OR @@TRANCOUNT=0 BEGIN IF @@TRANCOUNT>0 ROLLBACK SET NOEXEC ON END
GO

--
-- Создать процедуру [dbo].[SP_GET_SETTING_VALUE]
--
GO

CREATE PROCEDURE [dbo].[SP_GET_SETTING_VALUE]
	@Code  NVARCHAR(50),
	@Value NVARCHAR(250) OUTPUT
AS
BEGIN
  SET @Value = '';
  SET @Code = ISNULL(LOWER(LTRIM(RTRIM(@Code))), '');

  SELECT @Value = s.Value
  FROM dbo.MT_SETTING s
  WHERE LOWER(s.Code) = @Code;
END
GO
IF @@ERROR<>0 OR @@TRANCOUNT=0 BEGIN IF @@TRANCOUNT>0 ROLLBACK SET NOEXEC ON END
GO

--
-- Создать таблицу [dbo].[MT_LOAD_RULE]
--
CREATE TABLE [dbo].[MT_LOAD_RULE] (
  [LoadRuleId] [bigint] IDENTITY,
  [Code] [nvarchar](50) NOT NULL,
  [Pattern] [nvarchar](100) NOT NULL,
  [Method] [nvarchar](100) NOT NULL,
  [Descr] [nvarchar](250) NOT NULL,
  [IsActive] [bit] NOT NULL,
  [Ord] [int] NOT NULL,
  CONSTRAINT [PK_MT_LOAD_RULE] PRIMARY KEY CLUSTERED ([LoadRuleId])
)
ON [PRIMARY]
GO
IF @@ERROR<>0 OR @@TRANCOUNT=0 BEGIN IF @@TRANCOUNT>0 ROLLBACK SET NOEXEC ON END
GO

--
-- Создать таблицу [dbo].[MT_LOAD_RULE_SPEC]
--
CREATE TABLE [dbo].[MT_LOAD_RULE_SPEC] (
  [LoadRuleSpecId] [bigint] IDENTITY,
  [LoadRuleId] [bigint] NOT NULL,
  [Data] [varbinary](max) NULL,
  [MimeType] [nvarchar](50) NULL,
  [FileName] [nvarchar](100) NULL,
  [Size] [int] NULL,
  [PathToFile] [nvarchar](250) NOT NULL,
  [IsMain] [bit] NOT NULL,
  [DateLoad] [datetime] NOT NULL,
  CONSTRAINT [PK_MT_LOAD_RULE_SPEC] PRIMARY KEY CLUSTERED ([LoadRuleSpecId])
)
ON [PRIMARY]
TEXTIMAGE_ON [PRIMARY]
GO
IF @@ERROR<>0 OR @@TRANCOUNT=0 BEGIN IF @@TRANCOUNT>0 ROLLBACK SET NOEXEC ON END
GO

--
-- Создать индекс [FK_MT_LOAD_RULE_SPEC_MT_LOAD_RULE] для объекта типа таблица [dbo].[MT_LOAD_RULE_SPEC]
--
CREATE INDEX [FK_MT_LOAD_RULE_SPEC_MT_LOAD_RULE]
  ON [dbo].[MT_LOAD_RULE_SPEC] ([LoadRuleId])
  ON [PRIMARY]
GO
IF @@ERROR<>0 OR @@TRANCOUNT=0 BEGIN IF @@TRANCOUNT>0 ROLLBACK SET NOEXEC ON END
GO

--
-- Создать триггер [TR_FOR_INS_UPD_MT_LOAD_RULE_SPEC] на таблицу [dbo].[MT_LOAD_RULE_SPEC]
--
GO

CREATE TRIGGER [TR_FOR_INS_UPD_MT_LOAD_RULE_SPEC] ON [dbo].[MT_LOAD_RULE_SPEC] FOR INSERT, UPDATE
AS
BEGIN TRAN
  DECLARE @error NVARCHAR(100);

  --check data--
  IF (EXISTS(SELECT i.LoadRuleSpecId
			 FROM INSERTED i
			 WHERE NULLIF(i.Data, 0x00) IS NULL))
  BEGIN
	SET @error = 'Файл не выбран. Отсутствуют данные.';
    RAISERROR(@error, 16, 1)
	ROLLBACK TRAN    
  END  
  
  --check filename--
  IF (EXISTS(SELECT i.LoadRuleSpecId
			 FROM INSERTED i
			 WHERE ISNULL(LTRIM(RTRIM(i.FileName)), '') = ''))
  BEGIN
	SET @error = 'Не указано наименование файла.';
    RAISERROR(@error, 16, 1)
	ROLLBACK TRAN    
  END

  --check mimetype--
  IF (EXISTS(SELECT i.LoadRuleSpecId
			 FROM INSERTED i
			 WHERE ISNULL(LOWER(i.MimeType), '') NOT LIKE '%xml%'))
  BEGIN
	SET @error = 'Тип содержимого MIME файла не является xml.';
    RAISERROR(@error, 16, 1)
	ROLLBACK TRAN    
  END

  --check ismain
  IF (EXISTS(SELECT 1
			 FROM dbo.MT_LOAD_RULE_SPEC lrs
			      JOIN (SELECT ins.LoadRuleId
						FROM INSERTED ins
						GROUP BY ins.LoadRuleId) i
				  ON lrs.LoadRuleId = i.LoadRuleId
			 WHERE lrs.IsMain = 1
			 GROUP BY lrs.LoadRuleId
			 HAVING COUNT(lrs.LoadRuleSpecId) > 1))
  BEGIN
	SET @error = 'Главный в правиле загрузки должен быть один.';
    RAISERROR(@error, 16, 1)
	ROLLBACK TRAN    
  END  
  
  COMMIT TRAN
GO
IF @@ERROR<>0 OR @@TRANCOUNT=0 BEGIN IF @@TRANCOUNT>0 ROLLBACK SET NOEXEC ON END
GO

--
-- Создать внешний ключ [FK_MT_LOAD_RULE_SPEC_MT_LOAD_RULE] для объекта типа таблица [dbo].[MT_LOAD_RULE_SPEC]
--
ALTER TABLE [dbo].[MT_LOAD_RULE_SPEC]
  ADD CONSTRAINT [FK_MT_LOAD_RULE_SPEC_MT_LOAD_RULE] FOREIGN KEY ([LoadRuleId]) REFERENCES [dbo].[MT_LOAD_RULE] ([LoadRuleId])
GO
IF @@ERROR<>0 OR @@TRANCOUNT=0 BEGIN IF @@TRANCOUNT>0 ROLLBACK SET NOEXEC ON END
GO

--
-- Создать процедуру [dbo].[SP_GET_RULE_DATA]
--
GO

CREATE PROCEDURE [dbo].[SP_GET_RULE_DATA]
	@LoadRuleSpecId BIGINT
AS
BEGIN
  SELECT lrs.Data
  FROM dbo.MT_LOAD_RULE_SPEC lrs
  WHERE lrs.LoadRuleSpecId = @LoadRuleSpecId;
END
GO
IF @@ERROR<>0 OR @@TRANCOUNT=0 BEGIN IF @@TRANCOUNT>0 ROLLBACK SET NOEXEC ON END
GO

--
-- Создать процедуру [dbo].[SP_GET_LOAD_RULE]
--
GO

CREATE PROCEDURE [dbo].[SP_GET_LOAD_RULE]
	@Path NVARCHAR(1000)
AS
BEGIN
  SET @Path = ISNULL(LOWER(LTRIM(RTRIM(@Path))), '');

  SET @Path = 	   
        CASE LEN(@Path) 
	      WHEN 0 THEN @Path
          ELSE CASE 
			     WHEN SUBSTRING(@Path, LEN(@Path), 1) = '\' THEN LEFT(@Path, LEN(@Path)-1)
				 ELSE @Path
			   END			  			 			   
        END;

  SELECT lr.LoadRuleId, 
	     lr.Code, 
	     lr.Pattern, 
	     lr.Method,
	     lr.Descr,
	     lr.IsActive, 
	     lr.Ord,
	     lrs.LoadRuleSpecId, 
	     lrs.FileName, 
	     ISNULL(NULLIF(@Path, '') + '\', '') + lrs.PathToFile + '\' AS PathToFile,
	     lrs.IsMain   
  FROM dbo.MT_LOAD_RULE lr
	   JOIN dbo.MT_LOAD_RULE_SPEC lrs
	     ON lr.LoadRuleId = lrs.LoadRuleId
  ORDER BY CASE WHEN lr.IsActive = 1 THEN 1 ELSE 2 END, lr.Ord, 
           CASE WHEN lrs.IsMain = 1 THEN 1 ELSE 2 END;
END
GO
IF @@ERROR<>0 OR @@TRANCOUNT=0 BEGIN IF @@TRANCOUNT>0 ROLLBACK SET NOEXEC ON END
GO

--
-- Создать таблицу [dbo].[CT_VAT]
--
CREATE TABLE [dbo].[CT_VAT] (
  [VatId] [bigint] IDENTITY,
  [Code] [int] NOT NULL,
  [Name] [nvarchar](100) NOT NULL,
  [IsActive] [bit] NOT NULL,
  [DateLoad] [datetime] NULL,
  CONSTRAINT [PK_CT_VAT] PRIMARY KEY CLUSTERED ([VatId])
)
ON [PRIMARY]
GO
IF @@ERROR<>0 OR @@TRANCOUNT=0 BEGIN IF @@TRANCOUNT>0 ROLLBACK SET NOEXEC ON END
GO

--
-- Создать индекс [AK_CT_VAT] для объекта типа таблица [dbo].[CT_VAT]
--
CREATE UNIQUE INDEX [AK_CT_VAT]
  ON [dbo].[CT_VAT] ([Code])
  ON [PRIMARY]
GO
IF @@ERROR<>0 OR @@TRANCOUNT=0 BEGIN IF @@TRANCOUNT>0 ROLLBACK SET NOEXEC ON END
GO

--
-- Создать процедуру [dbo].[SP_IM_VAT]
--
GO

CREATE PROCEDURE [dbo].[SP_IM_VAT]
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
IF @@ERROR<>0 OR @@TRANCOUNT=0 BEGIN IF @@TRANCOUNT>0 ROLLBACK SET NOEXEC ON END
GO

--
-- Создать таблицу [dbo].[CT_IMAGE]
--
CREATE TABLE [dbo].[CT_IMAGE] (
  [ImageId] [bigint] IDENTITY,
  [Data] [varbinary](max) NULL,
  [MimeType] [nvarchar](50) NULL,
  [FileName] [nvarchar](100) NULL,
  [Size] [int] NULL,
  [DateLoad] [datetime] NOT NULL,
  CONSTRAINT [PK_CT_IMAGE] PRIMARY KEY CLUSTERED ([ImageId])
)
ON [PRIMARY]
TEXTIMAGE_ON [PRIMARY]
GO
IF @@ERROR<>0 OR @@TRANCOUNT=0 BEGIN IF @@TRANCOUNT>0 ROLLBACK SET NOEXEC ON END
GO

--
-- Создать таблицу [dbo].[CT_CATEGORY]
--
CREATE TABLE [dbo].[CT_CATEGORY] (
  [CategoryId] [bigint] IDENTITY,
  [Code] [nvarchar](100) NOT NULL,
  [Name] [nvarchar](250) NOT NULL,
  [Ord] [int] NULL,
  [DateLoad] [datetime] NULL,
  CONSTRAINT [PK_CT_CATEGORY] PRIMARY KEY CLUSTERED ([CategoryId])
)
ON [PRIMARY]
GO
IF @@ERROR<>0 OR @@TRANCOUNT=0 BEGIN IF @@TRANCOUNT>0 ROLLBACK SET NOEXEC ON END
GO

--
-- Создать индекс [AK_CT_CATEGORY] для объекта типа таблица [dbo].[CT_CATEGORY]
--
CREATE UNIQUE INDEX [AK_CT_CATEGORY]
  ON [dbo].[CT_CATEGORY] ([Code])
  ON [PRIMARY]
GO
IF @@ERROR<>0 OR @@TRANCOUNT=0 BEGIN IF @@TRANCOUNT>0 ROLLBACK SET NOEXEC ON END
GO

--
-- Создать процедуру [dbo].[SP_IM_CATEGORY]
--
GO

CREATE PROCEDURE [dbo].[SP_IM_CATEGORY]
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
IF @@ERROR<>0 OR @@TRANCOUNT=0 BEGIN IF @@TRANCOUNT>0 ROLLBACK SET NOEXEC ON END
GO

--
-- Создать таблицу [dbo].[SK_EQUIPMENT]
--
CREATE TABLE [dbo].[SK_EQUIPMENT] (
  [EquipmentId] [bigint] IDENTITY,
  [CategoryId] [bigint] NOT NULL,
  [Code] [nvarchar](50) NOT NULL,
  [Name] [nvarchar](500) NOT NULL,
  [NameExtra] [nvarchar](500) NULL,
  [Ord] [int] NULL,
  [IsActive] [bit] NOT NULL,
  CONSTRAINT [PK_SK_EQUIPMENT] PRIMARY KEY CLUSTERED ([EquipmentId])
)
ON [PRIMARY]
GO
IF @@ERROR<>0 OR @@TRANCOUNT=0 BEGIN IF @@TRANCOUNT>0 ROLLBACK SET NOEXEC ON END
GO

--
-- Создать индекс [AK_SK_EQUIPMENT] для объекта типа таблица [dbo].[SK_EQUIPMENT]
--
CREATE UNIQUE INDEX [AK_SK_EQUIPMENT]
  ON [dbo].[SK_EQUIPMENT] ([Code])
  ON [PRIMARY]
GO
IF @@ERROR<>0 OR @@TRANCOUNT=0 BEGIN IF @@TRANCOUNT>0 ROLLBACK SET NOEXEC ON END
GO

--
-- Создать индекс [FK_SK_EQUIPMENT_CT_CATEGORY] для объекта типа таблица [dbo].[SK_EQUIPMENT]
--
CREATE INDEX [FK_SK_EQUIPMENT_CT_CATEGORY]
  ON [dbo].[SK_EQUIPMENT] ([CategoryId])
  ON [PRIMARY]
GO
IF @@ERROR<>0 OR @@TRANCOUNT=0 BEGIN IF @@TRANCOUNT>0 ROLLBACK SET NOEXEC ON END
GO

--
-- Создать внешний ключ [FK_SK_EQUIPMENT_CT_CATEGORY] для объекта типа таблица [dbo].[SK_EQUIPMENT]
--
ALTER TABLE [dbo].[SK_EQUIPMENT]
  ADD CONSTRAINT [FK_SK_EQUIPMENT_CT_CATEGORY] FOREIGN KEY ([CategoryId]) REFERENCES [dbo].[CT_CATEGORY] ([CategoryId])
GO
IF @@ERROR<>0 OR @@TRANCOUNT=0 BEGIN IF @@TRANCOUNT>0 ROLLBACK SET NOEXEC ON END
GO

--
-- Создать процедуру [dbo].[SP_SET_EQUIPMENT_ISACTIVE]
--
GO

--
-- procedure sp_set_equipment_isactive
--
CREATE PROCEDURE [dbo].[SP_SET_EQUIPMENT_ISACTIVE]
	@IsActive BIT
AS
BEGIN
	UPDATE dbo.SK_EQUIPMENT
	SET IsActive = @IsActive;
END
GO
IF @@ERROR<>0 OR @@TRANCOUNT=0 BEGIN IF @@TRANCOUNT>0 ROLLBACK SET NOEXEC ON END
GO

--
-- Создать таблицу [dbo].[CT_BRAND]
--
CREATE TABLE [dbo].[CT_BRAND] (
  [BrandId] [bigint] IDENTITY,
  [Code] [nvarchar](100) NOT NULL,
  [Name] [nvarchar](500) NOT NULL,
  [DateLoad] [datetime] NULL,
  CONSTRAINT [PK_CT_BRAND] PRIMARY KEY CLUSTERED ([BrandId])
)
ON [PRIMARY]
GO
IF @@ERROR<>0 OR @@TRANCOUNT=0 BEGIN IF @@TRANCOUNT>0 ROLLBACK SET NOEXEC ON END
GO

--
-- Создать индекс [AK_CT_BRAND] для объекта типа таблица [dbo].[CT_BRAND]
--
CREATE UNIQUE INDEX [AK_CT_BRAND]
  ON [dbo].[CT_BRAND] ([Code])
  ON [PRIMARY]
GO
IF @@ERROR<>0 OR @@TRANCOUNT=0 BEGIN IF @@TRANCOUNT>0 ROLLBACK SET NOEXEC ON END
GO

--
-- Создать процедуру [dbo].[SP_IM_BRAND]
--
GO

CREATE PROCEDURE [dbo].[SP_IM_BRAND]
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
	SELECT im.Code, im.Name, im.DateLoad
	FROM (SELECT @Code AS Code, 
	             @Name AS Name, 
				 @DateCur AS DateLoad) im 
	     LEFT JOIN CT_BRAND b 
		   ON im.Code = b.Code
	WHERE b.BrandId IS NULL
END
GO
IF @@ERROR<>0 OR @@TRANCOUNT=0 BEGIN IF @@TRANCOUNT>0 ROLLBACK SET NOEXEC ON END
GO

--
-- Создать таблицу [dbo].[SK_MODEL]
--
CREATE TABLE [dbo].[SK_MODEL] (
  [ModelId] [bigint] IDENTITY,
  [BrandId] [bigint] NOT NULL,
  [Code] [bigint] NOT NULL,
  [Name] [nvarchar](500) NOT NULL,
  [DateLoad] [datetime] NULL,
  CONSTRAINT [PK_SK_MODEL] PRIMARY KEY CLUSTERED ([ModelId])
)
ON [PRIMARY]
GO
IF @@ERROR<>0 OR @@TRANCOUNT=0 BEGIN IF @@TRANCOUNT>0 ROLLBACK SET NOEXEC ON END
GO

--
-- Создать индекс [AK_SK_MODEL] для объекта типа таблица [dbo].[SK_MODEL]
--
CREATE UNIQUE INDEX [AK_SK_MODEL]
  ON [dbo].[SK_MODEL] ([Code])
  ON [PRIMARY]
GO
IF @@ERROR<>0 OR @@TRANCOUNT=0 BEGIN IF @@TRANCOUNT>0 ROLLBACK SET NOEXEC ON END
GO

--
-- Создать индекс [FK_SK_MODEL_CT_BRAND] для объекта типа таблица [dbo].[SK_MODEL]
--
CREATE INDEX [FK_SK_MODEL_CT_BRAND]
  ON [dbo].[SK_MODEL] ([BrandId])
  ON [PRIMARY]
GO
IF @@ERROR<>0 OR @@TRANCOUNT=0 BEGIN IF @@TRANCOUNT>0 ROLLBACK SET NOEXEC ON END
GO

--
-- Создать внешний ключ [FK_SK_MODEL_CT_BRAND] для объекта типа таблица [dbo].[SK_MODEL]
--
ALTER TABLE [dbo].[SK_MODEL]
  ADD CONSTRAINT [FK_SK_MODEL_CT_BRAND] FOREIGN KEY ([BrandId]) REFERENCES [dbo].[CT_BRAND] ([BrandId])
GO
IF @@ERROR<>0 OR @@TRANCOUNT=0 BEGIN IF @@TRANCOUNT>0 ROLLBACK SET NOEXEC ON END
GO

--
-- Создать процедуру [dbo].[SP_IM_MODEL]
--
GO

CREATE PROCEDURE [dbo].[SP_IM_MODEL]
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
GO
IF @@ERROR<>0 OR @@TRANCOUNT=0 BEGIN IF @@TRANCOUNT>0 ROLLBACK SET NOEXEC ON END
GO

--
-- Создать функцию [dbo].[FN_GET_VAT_PRVAT]
--
GO

CREATE FUNCTION [dbo].[FN_GET_VAT_PRVAT]
(
	@PriceWithVat DECIMAL(17,2),
	@Percent INT 
)
RETURNS DECIMAL(17,2)
AS
BEGIN
	RETURN ROUND(@PriceWithVat * CAST(@Percent AS DECIMAL(17,2))/(100 + @Percent), 2)
END
GO
IF @@ERROR<>0 OR @@TRANCOUNT=0 BEGIN IF @@TRANCOUNT>0 ROLLBACK SET NOEXEC ON END
GO

--
-- Создать функцию [dbo].[FN_GET_PR_PRVAT]
--
GO

CREATE FUNCTION [dbo].[FN_GET_PR_PRVAT]
(
	@PriceWithVat DECIMAL(17,2),
	@Percent INT 
)
RETURNS DECIMAL(17,2)
AS
BEGIN
	RETURN @PriceWithVat - dbo.FN_GET_VAT_PRVAT(@PriceWithVat, @Percent)
END
GO
IF @@ERROR<>0 OR @@TRANCOUNT=0 BEGIN IF @@TRANCOUNT>0 ROLLBACK SET NOEXEC ON END
GO

--
-- Создать функцию [dbo].[FN_TRIM_STRING]
--
GO

CREATE FUNCTION [dbo].[FN_TRIM_STRING]
(
	@String NVARCHAR(4000)	
)
RETURNS NVARCHAR(4000)
AS
BEGIN
	DECLARE @Value NVARCHAR(4000),
			@Delimiter NVARCHAR(5),
			@Pos INT;

	SELECT @String = LTRIM(RTRIM(@String)),
	       @Delimiter = ' ',
		   @Value = '';

	IF(NULLIF(@String, '') IS NULL)
	BEGIN 
		SET @Value = @String;
	END 
	ELSE
	BEGIN
		WHILE LEN(@String) > 0
		BEGIN 
			SELECT @Pos = CASE CHARINDEX(@Delimiter, @String) 
						      WHEN 0 THEN LEN(@String) 
						      ELSE CHARINDEX(@Delimiter, @String) 
						  END;
	    
			IF (@Pos != LEN(@String))
			BEGIN 
    			WHILE (SUBSTRING(@String, @Pos, 1) = SUBSTRING(@String, @Pos+1, 1))
				BEGIN
					SET @String = SUBSTRING(@String, 1, @Pos) + SUBSTRING(@String, @Pos+2, LEN(@String));
				END
			END

			SET @Value = ISNULL(@Value, '') + SUBSTRING(@String, 1, @Pos);

			SELECT @String = CASE 
			                     WHEN @pos != LEN(@String) THEN RIGHT(@String, LEN(@String) - @Pos) 
			                     ELSE ''
							 END;
		END
	END

	RETURN @Value;
END
GO
IF @@ERROR<>0 OR @@TRANCOUNT=0 BEGIN IF @@TRANCOUNT>0 ROLLBACK SET NOEXEC ON END
GO

--
-- Создать таблицу [dbo].[RS_PRODUCT]
--
CREATE TABLE [dbo].[RS_PRODUCT] (
  [ProductId] [bigint] IDENTITY,
  [EquipmentId] [bigint] NOT NULL,
  [ModelId] [bigint] NOT NULL,
  [ImageId] [bigint] NULL,
  [Name] [nvarchar](150) NOT NULL,
  [Descr] [nvarchar](2000) NULL,
  [Mass] [decimal](10, 3) NULL,
  [Length] [decimal](10, 2) NULL,
  [Width] [decimal](10, 2) NULL,
  [Height] [decimal](10, 2) NULL,
  [Color] [nvarchar](50) NULL,
  [Power] [int] NULL,
  [Kit] [nvarchar](250) NULL,
  [IsActive] [bit] NOT NULL,
  CONSTRAINT [PK_RS_PRODUCT] PRIMARY KEY CLUSTERED ([ProductId])
)
ON [PRIMARY]
GO
IF @@ERROR<>0 OR @@TRANCOUNT=0 BEGIN IF @@TRANCOUNT>0 ROLLBACK SET NOEXEC ON END
GO

--
-- Создать индекс [FK_RS_PRODUCT_CT_IMAGE] для объекта типа таблица [dbo].[RS_PRODUCT]
--
CREATE INDEX [FK_RS_PRODUCT_CT_IMAGE]
  ON [dbo].[RS_PRODUCT] ([ImageId])
  ON [PRIMARY]
GO
IF @@ERROR<>0 OR @@TRANCOUNT=0 BEGIN IF @@TRANCOUNT>0 ROLLBACK SET NOEXEC ON END
GO

--
-- Создать индекс [FK_RS_PRODUCT_SK_EQUIPMENT] для объекта типа таблица [dbo].[RS_PRODUCT]
--
CREATE INDEX [FK_RS_PRODUCT_SK_EQUIPMENT]
  ON [dbo].[RS_PRODUCT] ([EquipmentId])
  ON [PRIMARY]
GO
IF @@ERROR<>0 OR @@TRANCOUNT=0 BEGIN IF @@TRANCOUNT>0 ROLLBACK SET NOEXEC ON END
GO

--
-- Создать индекс [FK_RS_PRODUCT_SK_MODEL] для объекта типа таблица [dbo].[RS_PRODUCT]
--
CREATE INDEX [FK_RS_PRODUCT_SK_MODEL]
  ON [dbo].[RS_PRODUCT] ([ModelId])
  ON [PRIMARY]
GO
IF @@ERROR<>0 OR @@TRANCOUNT=0 BEGIN IF @@TRANCOUNT>0 ROLLBACK SET NOEXEC ON END
GO

--
-- Создать триггер [TR_FOR_INS_UPD_RS_PRODUCT] на таблицу [dbo].[RS_PRODUCT]
--
GO

CREATE TRIGGER [TR_FOR_INS_UPD_RS_PRODUCT] ON [dbo].[RS_PRODUCT] FOR INSERT, UPDATE
AS
BEGIN TRAN

  UPDATE dbo.RS_PRODUCT
  SET Descr = dbo.FN_TRIM_STRING(Descr)
  WHERE ProductId IN (SELECT i.ProductId 
                      FROM INSERTED i);
  COMMIT TRAN

GO
IF @@ERROR<>0 OR @@TRANCOUNT=0 BEGIN IF @@TRANCOUNT>0 ROLLBACK SET NOEXEC ON END
GO

--
-- Создать внешний ключ [FK_RS_PRODUCT_CT_IMAGE] для объекта типа таблица [dbo].[RS_PRODUCT]
--
ALTER TABLE [dbo].[RS_PRODUCT]
  ADD CONSTRAINT [FK_RS_PRODUCT_CT_IMAGE] FOREIGN KEY ([ImageId]) REFERENCES [dbo].[CT_IMAGE] ([ImageId])
GO
IF @@ERROR<>0 OR @@TRANCOUNT=0 BEGIN IF @@TRANCOUNT>0 ROLLBACK SET NOEXEC ON END
GO

--
-- Создать внешний ключ [FK_RS_PRODUCT_SK_EQUIPMENT] для объекта типа таблица [dbo].[RS_PRODUCT]
--
ALTER TABLE [dbo].[RS_PRODUCT]
  ADD CONSTRAINT [FK_RS_PRODUCT_SK_EQUIPMENT] FOREIGN KEY ([EquipmentId]) REFERENCES [dbo].[SK_EQUIPMENT] ([EquipmentId])
GO
IF @@ERROR<>0 OR @@TRANCOUNT=0 BEGIN IF @@TRANCOUNT>0 ROLLBACK SET NOEXEC ON END
GO

--
-- Создать внешний ключ [FK_RS_PRODUCT_SK_MODEL] для объекта типа таблица [dbo].[RS_PRODUCT]
--
ALTER TABLE [dbo].[RS_PRODUCT]
  ADD CONSTRAINT [FK_RS_PRODUCT_SK_MODEL] FOREIGN KEY ([ModelId]) REFERENCES [dbo].[SK_MODEL] ([ModelId])
GO
IF @@ERROR<>0 OR @@TRANCOUNT=0 BEGIN IF @@TRANCOUNT>0 ROLLBACK SET NOEXEC ON END
GO

--
-- Создать процедуру [dbo].[SP_RFR_EQUIPMENT_ISACTIVE]
--
GO

--
-- procedure sp_refresh_equipment_isactive
--
CREATE PROCEDURE [dbo].[SP_RFR_EQUIPMENT_ISACTIVE]
AS
BEGIN
	UPDATE eq
	SET eq.IsActive = CASE WHEN pr.EquipmentId IS NOT NULL THEN 1 ELSE 0 END
	FROM dbo.SK_EQUIPMENT eq
		 LEFT JOIN (SELECT DISTINCT p.EquipmentId 
					FROM dbo.RS_PRODUCT p
					WHERE p.IsActive = 1) pr
		   ON eq.EquipmentId = pr.EquipmentId;

END
GO
IF @@ERROR<>0 OR @@TRANCOUNT=0 BEGIN IF @@TRANCOUNT>0 ROLLBACK SET NOEXEC ON END
GO

--
-- Создать таблицу [dbo].[RS_PRICE]
--
CREATE TABLE [dbo].[RS_PRICE] (
  [PriceId] [bigint] IDENTITY,
  [ProductId] [bigint] NOT NULL,
  [VatId] [bigint] NOT NULL,
  [PriceWithVat] [decimal](17, 2) NOT NULL,
  [PriceWithoutVat] [decimal](17, 2) NULL,
  [DateBegin] [datetime] NOT NULL,
  [DateEnd] [datetime] NULL,
  CONSTRAINT [PK_RS_PRICE] PRIMARY KEY CLUSTERED ([PriceId])
)
ON [PRIMARY]
GO
IF @@ERROR<>0 OR @@TRANCOUNT=0 BEGIN IF @@TRANCOUNT>0 ROLLBACK SET NOEXEC ON END
GO

--
-- Создать индекс [FK_RS_PRICE_CT_VAT] для объекта типа таблица [dbo].[RS_PRICE]
--
CREATE INDEX [FK_RS_PRICE_CT_VAT]
  ON [dbo].[RS_PRICE] ([VatId])
  ON [PRIMARY]
GO
IF @@ERROR<>0 OR @@TRANCOUNT=0 BEGIN IF @@TRANCOUNT>0 ROLLBACK SET NOEXEC ON END
GO

--
-- Создать индекс [FK_RS_PRICE_RS_PRODUCT] для объекта типа таблица [dbo].[RS_PRICE]
--
CREATE INDEX [FK_RS_PRICE_RS_PRODUCT]
  ON [dbo].[RS_PRICE] ([ProductId])
  ON [PRIMARY]
GO
IF @@ERROR<>0 OR @@TRANCOUNT=0 BEGIN IF @@TRANCOUNT>0 ROLLBACK SET NOEXEC ON END
GO

--
-- Создать триггер [TR_FOR_INS_UPD_RS_PRICE] на таблицу [dbo].[RS_PRICE]
--
GO
CREATE TRIGGER [TR_FOR_INS_UPD_RS_PRICE] ON [dbo].[RS_PRICE] FOR INSERT, UPDATE
AS
BEGIN TRAN
  DECLARE @error NVARCHAR(100);
  DECLARE @maxDate DATETIME = CAST('9999-12-31 23:59:59.997' AS DATETIME);

  --pricewithoutvat and dateend--
  UPDATE dbo.RS_PRICE
  SET PriceWithoutVat = dbo.FN_GET_PR_PRVAT(dbo.RS_PRICE.PriceWithVat, (SELECT DISTINCT v.Code FROM CT_VAT v WHERE v.VatId = dbo.RS_PRICE.VatId)),
      DateEnd = DATEADD(dd, 1, DATEADD(ms, -3, DateEnd))
  WHERE PriceId IN (SELECT i.PriceId FROM INSERTED i);

  --check--
  IF (EXISTS(SELECT prc.PriceId
             FROM INSERTED i
			      JOIN RS_PRICE prc
				    ON i.ProductId = prc.ProductId
					   AND i.PriceId != prc.PriceId
					   AND i.DateBegin <= ISNULL(prc.DateEnd, @maxDate)
					   AND prc.DateBegin <= ISNULL(i.DateEnd, @maxDate)))
  BEGIN
	SET @error = 'Пересечение периодов цен.';
    RAISERROR(@error, 16, 1)
	ROLLBACK TRAN    
  END
  COMMIT TRAN
GO
IF @@ERROR<>0 OR @@TRANCOUNT=0 BEGIN IF @@TRANCOUNT>0 ROLLBACK SET NOEXEC ON END
GO

--
-- Создать внешний ключ [FK_RS_PRICE_CT_VAT] для объекта типа таблица [dbo].[RS_PRICE]
--
ALTER TABLE [dbo].[RS_PRICE]
  ADD CONSTRAINT [FK_RS_PRICE_CT_VAT] FOREIGN KEY ([VatId]) REFERENCES [dbo].[CT_VAT] ([VatId])
GO
IF @@ERROR<>0 OR @@TRANCOUNT=0 BEGIN IF @@TRANCOUNT>0 ROLLBACK SET NOEXEC ON END
GO

--
-- Создать внешний ключ [FK_RS_PRICE_RS_PRODUCT] для объекта типа таблица [dbo].[RS_PRICE]
--
ALTER TABLE [dbo].[RS_PRICE]
  ADD CONSTRAINT [FK_RS_PRICE_RS_PRODUCT] FOREIGN KEY ([ProductId]) REFERENCES [dbo].[RS_PRODUCT] ([ProductId])
GO
IF @@ERROR<>0 OR @@TRANCOUNT=0 BEGIN IF @@TRANCOUNT>0 ROLLBACK SET NOEXEC ON END
GO

--
-- Создать представление [dbo].[V_PRODUCT]
--
GO

CREATE VIEW [dbo].[V_PRODUCT]
AS 
SELECT pr.ProductId, pr.EquipmentId, eq.CategoryId, pr.ModelId, md.BrandId, pr.ImageId, 
	   pr.Name, pr.Descr, pr.Mass, pr.Length, pr.Width, pr.Height, pr.Color, pr.Power, pr.Kit,
	   eq.Name EquipmentName, eq.NameExtra EquipmentNameExtra,
	   ct.Name CategoryName, br.Name BrandName, md.Name ModelName,
	   im.Data, im.MimeType, im.FileName ImageName,
	   prc.PriceWithVat, prc.PriceWithoutVat, prc.DateBegin, prc.DateEnd,
	   v.Code VatCode, v.Name VatName, v.IsActive VatIsActive
FROM RS_PRODUCT pr
     JOIN SK_EQUIPMENT eq
	   ON pr.EquipmentId = eq.EquipmentId
     LEFT JOIN CT_CATEGORY ct 
	   ON eq.CategoryId = ct.CategoryId     
     JOIN SK_MODEL md 
	   ON pr.ModelId = md.ModelId
	 JOIN CT_BRAND br 
	   ON md.BrandId = br.BrandId
	 LEFT JOIN CT_IMAGE im
	   ON pr.ImageId = im.ImageId
     LEFT JOIN RS_PRICE prc 
	   ON pr.ProductId = prc.ProductId
          AND GETDATE() BETWEEN prc.DateBegin AND prc.DateEnd
	 LEFT JOIN CT_VAT v 
	   ON prc.VatId = v.VatId
	      AND v.IsActive = 1;
GO
IF @@ERROR<>0 OR @@TRANCOUNT=0 BEGIN IF @@TRANCOUNT>0 ROLLBACK SET NOEXEC ON END
GO

--
-- Создать таблицу [dbo].[RS_CART]
--
CREATE TABLE [dbo].[RS_CART] (
  [CartId] [bigint] IDENTITY,
  [OrderId] [bigint] NOT NULL,
  [ProductId] [bigint] NOT NULL,
  [PriceId] [bigint] NULL,
  [Quantity] [int] NOT NULL,
  CONSTRAINT [PK_RS_CART] PRIMARY KEY CLUSTERED ([CartId])
)
ON [PRIMARY]
GO
IF @@ERROR<>0 OR @@TRANCOUNT=0 BEGIN IF @@TRANCOUNT>0 ROLLBACK SET NOEXEC ON END
GO

--
-- Создать индекс [FK_RS_CART_RS_ORDER] для объекта типа таблица [dbo].[RS_CART]
--
CREATE INDEX [FK_RS_CART_RS_ORDER]
  ON [dbo].[RS_CART] ([OrderId])
  ON [PRIMARY]
GO
IF @@ERROR<>0 OR @@TRANCOUNT=0 BEGIN IF @@TRANCOUNT>0 ROLLBACK SET NOEXEC ON END
GO

--
-- Создать индекс [FK_RS_CART_RS_PRICE] для объекта типа таблица [dbo].[RS_CART]
--
CREATE INDEX [FK_RS_CART_RS_PRICE]
  ON [dbo].[RS_CART] ([PriceId])
  ON [PRIMARY]
GO
IF @@ERROR<>0 OR @@TRANCOUNT=0 BEGIN IF @@TRANCOUNT>0 ROLLBACK SET NOEXEC ON END
GO

--
-- Создать индекс [FK_RS_CART_RS_PRODUCT] для объекта типа таблица [dbo].[RS_CART]
--
CREATE INDEX [FK_RS_CART_RS_PRODUCT]
  ON [dbo].[RS_CART] ([ProductId])
  ON [PRIMARY]
GO
IF @@ERROR<>0 OR @@TRANCOUNT=0 BEGIN IF @@TRANCOUNT>0 ROLLBACK SET NOEXEC ON END
GO

--
-- Создать внешний ключ [FK_RS_CART_RS_ORDER] для объекта типа таблица [dbo].[RS_CART]
--
ALTER TABLE [dbo].[RS_CART]
  ADD CONSTRAINT [FK_RS_CART_RS_ORDER] FOREIGN KEY ([OrderId]) REFERENCES [dbo].[RS_ORDER] ([OrderId])
GO
IF @@ERROR<>0 OR @@TRANCOUNT=0 BEGIN IF @@TRANCOUNT>0 ROLLBACK SET NOEXEC ON END
GO

--
-- Создать внешний ключ [FK_RS_CART_RS_PRICE] для объекта типа таблица [dbo].[RS_CART]
--
ALTER TABLE [dbo].[RS_CART]
  ADD CONSTRAINT [FK_RS_CART_RS_PRICE] FOREIGN KEY ([PriceId]) REFERENCES [dbo].[RS_PRICE] ([PriceId])
GO
IF @@ERROR<>0 OR @@TRANCOUNT=0 BEGIN IF @@TRANCOUNT>0 ROLLBACK SET NOEXEC ON END
GO

--
-- Создать внешний ключ [FK_RS_CART_RS_PRODUCT] для объекта типа таблица [dbo].[RS_CART]
--
ALTER TABLE [dbo].[RS_CART]
  ADD CONSTRAINT [FK_RS_CART_RS_PRODUCT] FOREIGN KEY ([ProductId]) REFERENCES [dbo].[RS_PRODUCT] ([ProductId])
GO
IF @@ERROR<>0 OR @@TRANCOUNT=0 BEGIN IF @@TRANCOUNT>0 ROLLBACK SET NOEXEC ON END
GO

--
-- Создать представление [dbo].[V_CART]
--
GO

CREATE VIEW [dbo].[V_CART]
AS 
SELECT crt.CartId, crt.OrderId,
       crt.ProductId, 
	   pr.Name ProductName, 
	   eq.Name EquipmentName,
	   crt.PriceId, 
	   CASE WHEN prc.PriceWithVat IS NOT NULL THEN prc.PriceWithVat ELSE 0 END Price,
	   crt.Quantity,
	   CASE WHEN prc.PriceWithVat IS NOT NULL THEN prc.PriceWithVat ELSE 0 END * crt.Quantity Summ
FROM RS_CART crt
	 JOIN RS_PRODUCT pr 
	   ON crt.ProductId = pr.ProductId
	 JOIN SK_EQUIPMENT eq 
	   ON pr.EquipmentId = eq.EquipmentId
	 LEFT JOIN RS_PRICE prc 
	   ON crt.PriceId = prc.PriceId;
GO
IF @@ERROR<>0 OR @@TRANCOUNT=0 BEGIN IF @@TRANCOUNT>0 ROLLBACK SET NOEXEC ON END
GO

--
-- Создать функцию [dbo].[FN_SPLIT]
--
GO

CREATE FUNCTION [dbo].[FN_SPLIT]
(
    @String     NVARCHAR(4000),
    @Delimiter  NVARCHAR(5),
	@WithDouble BIT
)
RETURNS @SplittedValues TABLE
(
    Id      INT IDENTITY(1,1) NOT NULL PRIMARY KEY,
	Value   NVARCHAR(100) 
)
AS
BEGIN
    DECLARE @Pos INT;

    WHILE LEN(@String) > 0
    BEGIN 
        SELECT @Pos = CASE CHARINDEX(@Delimiter, @String) 
						  WHEN 0 THEN LEN(@String) 
						  ELSE CHARINDEX(@Delimiter, @String) - 1
					  END;

        IF (@WithDouble = 1 OR
		    NOT EXISTS(SELECT Value 
		               FROM @SplittedValues 
			     	   WHERE Value = (SELECT CAST(SUBSTRING(@String, 1, @Pos) AS NVARCHAR(100))))
			)
		  INSERT INTO @SplittedValues (Value)  
		  SELECT CAST(SUBSTRING(@String, 1, @Pos) AS NVARCHAR(100))

        SELECT @String = CASE 
		                     WHEN @Pos != LEN(@String) THEN RIGHT(@String, LEN(@String) - @Pos - 1)
                             ELSE ''
					     END
    END 
    
	RETURN;
END
GO
IF @@ERROR<>0 OR @@TRANCOUNT=0 BEGIN IF @@TRANCOUNT>0 ROLLBACK SET NOEXEC ON END
GO

--
-- Создать функцию [dbo].[FN_GET_SPLIT]
--
GO

CREATE FUNCTION [dbo].[FN_GET_SPLIT]
(
    @String    NVARCHAR(4000),
    @Delimiter NVARCHAR(5),
	@Position  INT
)
RETURNS NVARCHAR(100)
AS
BEGIN
	DECLARE @Value NVARCHAR(100)

	SELECT @Value = LEFT(t.Value, 100)
	FROM dbo.FN_SPLIT(@String, @Delimiter, 1) t
	WHERE t.Id = @Position;

	RETURN ISNULL(LTRIM(RTRIM(@Value)), '');
END
GO
IF @@ERROR<>0 OR @@TRANCOUNT=0 BEGIN IF @@TRANCOUNT>0 ROLLBACK SET NOEXEC ON END
GO

--
-- Создать функцию [dbo].[FN_GET_VAT_PR]
--
GO

CREATE FUNCTION [dbo].[FN_GET_VAT_PR]
(
	@PriceWithoutVat DECIMAL(17,2),
	@Percent INT 
)
RETURNS DECIMAL(17,2)
AS
BEGIN
	RETURN ROUND(@PriceWithoutVat * CAST(@Percent AS DECIMAL(17,2))/100, 2)
END
GO
IF @@ERROR<>0 OR @@TRANCOUNT=0 BEGIN IF @@TRANCOUNT>0 ROLLBACK SET NOEXEC ON END
GO

--
-- Создать функцию [dbo].[FN_GET_PRVAT_PR]
--
GO

CREATE FUNCTION [dbo].[FN_GET_PRVAT_PR]
(
	@PriceWithoutVat DECIMAL(17,2),
	@Percent INT 
)
RETURNS DECIMAL(17,2)
AS
BEGIN
	RETURN @PriceWithoutVat + dbo.FN_GET_VAT_PR(@PriceWithoutVat, @Percent)
END
GO
IF @@ERROR<>0 OR @@TRANCOUNT=0 BEGIN IF @@TRANCOUNT>0 ROLLBACK SET NOEXEC ON END
GO

--
-- Создать функцию [dbo].[FN_GET_NUMBERS]
--
GO

CREATE FUNCTION [dbo].[FN_GET_NUMBERS]
(
    @From INT,
    @To   INT
)
RETURNS @Numbers TABLE
(
    Value INT
)
AS
BEGIN
	WITH t AS (SELECT n 
	           FROM (VALUES (0),(1),(2),(3),(4),(5),(6),(7),(8),(9)) v(n))
	
	INSERT INTO @Numbers (Value)
	SELECT tbl.n
	FROM (SELECT t1.n + t2.n*10 + t3.n*100 + t4.n*1000 + t5.n*10000 + t6.n*100000  AS n
		  FROM t t1,     
			   t t2,
			   t t3,
			   t t4, 
			   t t5,
			   t t6) tbl
	WHERE tbl.n BETWEEN @From AND @To
	ORDER BY tbl.n;
    
	RETURN;
END
GO
IF @@ERROR<>0 OR @@TRANCOUNT=0 BEGIN IF @@TRANCOUNT>0 ROLLBACK SET NOEXEC ON END
GO

--
-- Создать функцию [dbo].[FN_GET_PERIODS_QUART]
--
GO

CREATE FUNCTION [dbo].[FN_GET_PERIODS_QUART]
(
    @DateBegin DATETIME,
    @DateEnd   DATETIME
)
RETURNS @PeriodsQuart TABLE 
(
	Year      INT, 
	Quart     INT, 
	DateBegin DATETIME, 
	DateEnd   DATETIME
)
AS
BEGIN
	WITH Periods AS 
	(SELECT ROW_NUMBER() OVER (ORDER BY ty.Y, tq.Q) AS Id,
		    ty.Y, tq.Q , 
		    DATEADD(mm, (tq.Q -1) * 3, CONVERT(DATETIME, CAST(ty.Y AS NVARCHAR(4)) + '0101', 112)) AS DateBegin
	 FROM (SELECT n1.Value AS Y
	       FROM dbo.FN_GET_NUMBERS(YEAR(@DateBegin), YEAR(@DateEnd)) n1) ty
		   CROSS JOIN 
		  (SELECT n2.Value AS Q
		   FROM dbo.FN_GET_NUMBERS(1, 4) n2) tq)

    INSERT INTO @PeriodsQuart (Year, Quart, DateBegin, DateEnd)  
	SELECT tp.Y AS Year, 
	       tp.Q AS Quart, 
		   tp.DateBegin, 
		   DATEADD(dd, -1, DATEADD(qq, 1, tp.DateBegin)) AS DateEnd
	FROM Periods tp
	WHERE tp.Id >= (SELECT DISTINCT tp1.Id
					FROM Periods tp1
					WHERE @DateBegin BETWEEN tp1.DateBegin AND DATEADD(dd, -1, DATEADD(qq, 1, tp1.DateBegin)))
		  AND
		  tp.Id <= (SELECT DISTINCT tp2.Id
					FROM Periods tp2
					WHERE @DateEnd BETWEEN tp2.DateBegin AND DATEADD(dd, -1, DATEADD(qq, 1, tp2.DateBegin)))
	ORDER BY tp.Y, tp.Q;

	RETURN;
END
GO
IF @@ERROR<>0 OR @@TRANCOUNT=0 BEGIN IF @@TRANCOUNT>0 ROLLBACK SET NOEXEC ON END
GO

--
-- Создать функцию [dbo].[FN_GET_PERIODS_MONTH]
--
GO

CREATE FUNCTION [dbo].[FN_GET_PERIODS_MONTH]
(
    @DateBegin DATETIME,
    @DateEnd   DATETIME
)
RETURNS @PeriodsMonth TABLE 
(
	Year      INT, 
	Month     INT, 
	DateBegin DATETIME, 
	DateEnd   DATETIME,
	Quart     INT
)
AS
BEGIN
	WITH Periods AS 
	(SELECT ROW_NUMBER() OVER (ORDER BY ty.Y, tm.M) AS Id,
		    ty.Y, tm.M, 
		    DATEADD(mm, tm.M -1, CONVERT(DATETIME, CAST(ty.Y AS NVARCHAR(4)) + '0101', 112)) AS DateBegin
	 FROM (SELECT n1.Value AS Y
	       FROM dbo.FN_GET_NUMBERS(YEAR(@DateBegin), YEAR(@DateEnd)) n1) ty
		   CROSS JOIN 
		  (SELECT n2.Value AS M
		   FROM dbo.FN_GET_NUMBERS(1, 12) n2) tm)

    INSERT INTO @PeriodsMonth (Year, Month, DateBegin, DateEnd, Quart)  
	SELECT tp.Y AS Year, 
	       tp.M AS Month, 
		   tp.DateBegin, 
		   DATEADD(dd, -1, DATEADD(mm, 1, tp.DateBegin)) AS DateEnd,
		   DATEPART(qq, tp.DateBegin) AS Quart
	FROM Periods tp
	WHERE tp.Id >= (SELECT DISTINCT tp1.Id
					FROM Periods tp1
					WHERE @DateBegin BETWEEN tp1.DateBegin AND DATEADD(dd, -1, DATEADD(mm, 1, tp1.DateBegin)))
		  AND
		  tp.Id <= (SELECT DISTINCT tp2.Id
					FROM Periods tp2
					WHERE @DateEnd BETWEEN tp2.DateBegin AND DATEADD(dd, -1, DATEADD(mm, 1, tp2.DateBegin)));

	RETURN;
END
GO
IF @@ERROR<>0 OR @@TRANCOUNT=0 BEGIN IF @@TRANCOUNT>0 ROLLBACK SET NOEXEC ON END
GO

--
-- Создать функцию [dbo].[FN_GET_WEEKDAYS]
--
GO

CREATE FUNCTION [dbo].[FN_GET_WEEKDAYS]
(	
    @DateBegin DATETIME,  
    @DateEnd   DATETIME  
)
RETURNS INT 
AS
BEGIN 
    DECLARE @Range INT; 
    SET @Range = DATEDIFF(DAY, @DateBegin, @DateEnd)+1; 
    RETURN  
    ( 
        SELECT @Range / 7 * 5                                                  --whole part
		       + @Range % 7                                                    --modulo
			   - (SELECT COUNT(*)                                              --modulo (weekend)
			      FROM (SELECT d 
						FROM (VALUES (1),(2),(3),(4),(5),(6),(7)) v(d)) tWeek
                  WHERE d <= @Range % 7  
                        AND DATEPART(WEEKDAY, @DateEnd - d + 1) IN (1, 7))     --days: sunday, saturday
    )
END  
GO
IF @@ERROR<>0 OR @@TRANCOUNT=0 BEGIN IF @@TRANCOUNT>0 ROLLBACK SET NOEXEC ON END
GO

--
-- Создать функцию [dbo].[FN_GET_QUART]
--
GO
CREATE FUNCTION [dbo].[FN_GET_QUART]
(
    @Date  DATETIME,
    @Quart SMALLINT = 0
)
RETURNS @Quarter TABLE 
(
	Quart SMALLINT, 
	DateBegin DATETIME, 
	DateEnd DATETIME
)
AS
BEGIN    
	DECLARE @DateQ DATETIME;
	SET @DateQ = CONVERT(DATETIME, CAST(YEAR(@Date) AS NVARCHAR(4)) + '0101', 112);

	WITH t AS (SELECT n FROM (VALUES (0),(1),(2),(3),(4),(5)) v(n)),
	     tbl AS (SELECT t.n AS Quart, DATEADD(qq, t.n - 1, @DateQ) AS DateBegin
	             FROM t)
	
	INSERT INTO @Quarter (Quart, DateBegin, DateEnd)  
	SELECT tq.Quart, 
	       tq.DateBegin, 
		   DATEADD(dd, -1, DATEADD(qq, 1, tq.DateBegin)) AS DateEnd
	FROM tbl tq
		 JOIN (SELECT Quart
			   FROM tbl
			   WHERE @Date BETWEEN DateBegin AND DATEADD(dd, -1, DATEADD(qq, 1, DateBegin))) tcur
	       ON tq.Quart BETWEEN tcur.Quart-1 AND tcur.Quart+1
	WHERE CASE @Quart 
			WHEN -1 THEN tcur.Quart-1
			WHEN 0 THEN tcur.Quart
			WHEN 1 THEN tcur.Quart+1
		  END = tq.Quart;

	RETURN;
END
GO
IF @@ERROR<>0 OR @@TRANCOUNT=0 BEGIN IF @@TRANCOUNT>0 ROLLBACK SET NOEXEC ON END
GO

--
-- Фиксировать транзакцию
--
IF @@TRANCOUNT>0 COMMIT TRANSACTION
GO

--
-- Установить NOEXEC в состояние off
--
SET NOEXEC OFF
GO