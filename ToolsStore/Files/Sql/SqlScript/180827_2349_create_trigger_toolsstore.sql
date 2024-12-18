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
-- Создать триггер [TR_FOR_INS_UPD_RS_PRODUCT] на таблицу [dbo].[RS_PRODUCT]
--
GO

CREATE TRIGGER [TR_FOR_INS_UPD_RS_PRODUCT] ON [dbo].[RS_PRODUCT] FOR INSERT, UPDATE
AS
BEGIN TRAN
  IF NOT EXISTS (SELECT *
                 FROM INSERTED i
			          JOIN SK_MODEL m
				        ON i.ModelId = m.ModelId
					      AND i.BrandId = m.BrandId)
  BEGIN
    RAISERROR('Discrepancy of model and brand', 16, 1)
	ROLLBACK TRAN
  END
COMMIT TRAN
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