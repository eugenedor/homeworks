SET CONCAT_NULL_YIELDS_NULL, ANSI_NULLS, ANSI_PADDING, QUOTED_IDENTIFIER, ANSI_WARNINGS, ARITHABORT, XACT_ABORT ON
SET NUMERIC_ROUNDABORT, IMPLICIT_TRANSACTIONS OFF
GO

USE ToolsStore
GO

IF DB_NAME() <> N'ToolsStore' SET NOEXEC ON
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
-- Создать таблицу [dbo].[MT_SETTING]
--
CREATE TABLE [dbo].[MT_SETTING] (
  [SettingId] [bigint] IDENTITY,
  [Code] [nvarchar](50) NOT NULL,
  [Value] [nvarchar](250) NOT NULL,
  [Description] [nvarchar](250) NOT NULL,
  [Enabled] [bit] NOT NULL,
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
-- Создать таблицу [dbo].[MT_LOAD_RULE]
--
CREATE TABLE [dbo].[MT_LOAD_RULE] (
  [LoadRuleId] [bigint] IDENTITY,
  [Code] [nvarchar](50) NOT NULL,
  [FileName] [nvarchar](100) NOT NULL,
  [IsActive] [bit] NOT NULL,
  [MethodLoad] [nvarchar](100) NOT NULL,
  [PathToXsd] [nvarchar](250) NOT NULL,
  [XsdName] [nvarchar](100) NOT NULL,
  [Descr] [nvarchar](250) NOT NULL,
  [Ord] [int] NOT NULL,
  CONSTRAINT [PK_MT_LOAD_RULE] PRIMARY KEY CLUSTERED ([LoadRuleId])
)
ON [PRIMARY]
GO
IF @@ERROR<>0 OR @@TRANCOUNT=0 BEGIN IF @@TRANCOUNT>0 ROLLBACK SET NOEXEC ON END
GO

--
-- Создать таблицу [dbo].[CT_VAT]
--
CREATE TABLE [dbo].[CT_VAT] (
  [VatId] [bigint] IDENTITY,
  [Vat] [bigint] NOT NULL,
  [Name] [nvarchar](100) NOT NULL,
  [Rem] [bit] NOT NULL,
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
  ON [dbo].[CT_VAT] ([Vat])
  ON [PRIMARY]
GO
IF @@ERROR<>0 OR @@TRANCOUNT=0 BEGIN IF @@TRANCOUNT>0 ROLLBACK SET NOEXEC ON END
GO

--
-- Создать таблицу [dbo].[CT_IMAGE]
--
CREATE TABLE [dbo].[CT_IMAGE] (
  [ImageId] [bigint] IDENTITY,
  [Data] [varbinary](max) NOT NULL,
  [MimeType] [varchar](50) NULL,
  [Name] [varchar](300) NULL,
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
-- Создать таблицу [dbo].[SK_EQUIPMENT]
--
CREATE TABLE [dbo].[SK_EQUIPMENT] (
  [EquipmentId] [bigint] IDENTITY,
  [CategoryId] [bigint] NULL,
  [Code] [nvarchar](50) NOT NULL,
  [Name] [nvarchar](500) NOT NULL,
  [NameExtra] [nvarchar](500) NULL,
  [Ord] [int] NULL,
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
-- Создать таблицу [dbo].[CT_BRAND]
--
CREATE TABLE [dbo].[CT_BRAND] (
  [BrandId] [bigint] IDENTITY,
  [Code] [nvarchar](100) NOT NULL,
  [Name] [nvarchar](500) NOT NULL,
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
-- Создать таблицу [dbo].[SK_MODEL]
--
CREATE TABLE [dbo].[SK_MODEL] (
  [ModelId] [bigint] IDENTITY,
  [BrandId] [bigint] NOT NULL,
  [Code] [bigint] NOT NULL,
  [Name] [nvarchar](500) NOT NULL,
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
-- Создать таблицу [dbo].[RS_PRODUCT]
--
CREATE TABLE [dbo].[RS_PRODUCT] (
  [ProductId] [bigint] IDENTITY,
  [EquipmentId] [bigint] NOT NULL,
  [BrandId] [bigint] NOT NULL,
  [ModelId] [bigint] NOT NULL,
  [ImageId] [bigint] NULL,
  [Name] [nvarchar](150) NOT NULL,
  [Descr] [nvarchar](2000) NULL,
  [Mass] [decimal](10, 3) NULL,
  [Length] [decimal](10, 2) NULL,
  [Width] [decimal](10, 2) NULL,
  [Height] [decimal](10, 2) NULL,
  [Color] [nvarchar](50) NULL,
  [Power] [bigint] NULL,
  [Kit] [nvarchar](250) NULL,
  CONSTRAINT [PK_RS_PRODUCT] PRIMARY KEY CLUSTERED ([ProductId])
)
ON [PRIMARY]
GO
IF @@ERROR<>0 OR @@TRANCOUNT=0 BEGIN IF @@TRANCOUNT>0 ROLLBACK SET NOEXEC ON END
GO

--
-- Создать индекс [FK_RS_PRODUCT_CT_BRAND] для объекта типа таблица [dbo].[RS_PRODUCT]
--
CREATE INDEX [FK_RS_PRODUCT_CT_BRAND]
  ON [dbo].[RS_PRODUCT] ([BrandId])
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
-- Создать внешний ключ [FK_RS_PRODUCT_CT_BRAND] для объекта типа таблица [dbo].[RS_PRODUCT]
--
ALTER TABLE [dbo].[RS_PRODUCT]
  ADD CONSTRAINT [FK_RS_PRODUCT_CT_BRAND] FOREIGN KEY ([BrandId]) REFERENCES [dbo].[CT_BRAND] ([BrandId])
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
-- Фиксировать транзакцию
--
IF @@TRANCOUNT>0 COMMIT TRANSACTION
GO

--
-- Установить NOEXEC в состояние off
--
SET NOEXEC OFF
GO