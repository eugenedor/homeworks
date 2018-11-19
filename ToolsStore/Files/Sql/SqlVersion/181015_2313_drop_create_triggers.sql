USE ToolsStore
GO

IF DB_NAME() <> N'ToolsStore' SET NOEXEC ON
GO

--
-- Change transaction localization level (Изменить уровень локализации транзакции)
--
SET TRANSACTION ISOLATION LEVEL SERIALIZABLE
GO

--
-- begin transaction
--
BEGIN TRANSACTION
GO

DROP TRIGGER dbo.TR_FOR_INS_UPD_RS_PRODUCT
GO
IF @@ERROR<>0 OR @@TRANCOUNT=0 BEGIN IF @@TRANCOUNT>0 ROLLBACK SET NOEXEC ON END
GO

CREATE TRIGGER dbo.TR_FOR_INS_UPD_RS_PRICE ON dbo.RS_PRICE FOR INSERT, UPDATE
AS
BEGIN TRAN
  DECLARE @error NVARCHAR(100);
  DECLARE @maxDate DATETIME = CAST('9999-12-31 23:59:59.997' AS DATETIME);

  --pricewithoutvat and dateend--
  UPDATE dbo.RS_PRICE
  SET PriceWithoutVat = CAST(ROUND(PriceWithVat*100/(100 + (SELECT DISTINCT CAST(v.Code AS DECIMAL(17,2)) FROM CT_VAT v WHERE v.VatId = dbo.RS_PRICE.VatId)), 2) AS DECIMAL(17,2)),
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
-- commit transaction
--
IF @@TRANCOUNT>0 COMMIT TRANSACTION
GO

--
-- set noexec to off (Установить NOEXEC в состояние off)
--
SET NOEXEC OFF
GO