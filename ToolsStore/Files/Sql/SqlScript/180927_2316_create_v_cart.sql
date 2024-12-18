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
-- Фиксировать транзакцию
--
IF @@TRANCOUNT>0 COMMIT TRANSACTION
GO

--
-- Установить NOEXEC в состояние off
--
SET NOEXEC OFF
GO