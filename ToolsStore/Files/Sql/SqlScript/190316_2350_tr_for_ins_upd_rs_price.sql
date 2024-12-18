ALTER TRIGGER [dbo].[TR_FOR_INS_UPD_RS_PRICE] ON [dbo].[RS_PRICE] FOR INSERT, UPDATE
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
