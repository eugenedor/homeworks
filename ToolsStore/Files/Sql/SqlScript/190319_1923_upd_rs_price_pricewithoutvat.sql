DISABLE TRIGGER dbo.TR_FOR_INS_UPD_RS_PRICE ON dbo.RS_PRICE;  
GO  

UPDATE dbo.RS_PRICE
SET PriceWithoutVat = dbo.FN_GET_PR_PRVAT(dbo.RS_PRICE.PriceWithVat, (SELECT DISTINCT v.Code FROM CT_VAT v WHERE v.VatId = dbo.RS_PRICE.VatId));
GO

ENABLE TRIGGER dbo.TR_FOR_INS_UPD_RS_PRICE ON dbo.RS_PRICE;  
GO