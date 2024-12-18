USE ToolsStore;
GO

--before
SELECT prc.PriceId, prc.ProductId, prc.VatId, prc.PriceWithVat, prc.PriceWithoutVat, prc.DateBegin, prc.DateEnd
FROM dbo.RS_PRICE prc
WHERE prc.ProductId = 1
ORDER BY prc.PriceId;

UPDATE dbo.RS_PRICE
SET DateEnd = CAST('2018-10-01' AS DATETIME)
WHERE PriceId = 1;

INSERT INTO dbo.RS_PRICE(ProductId, VatId, PriceWithVat, /*PriceWithoutVat,*/ DateBegin, DateEnd) VALUES (1, 3, 4590.00, /*3889.83,*/ CAST('2018-10-02' AS DATETIME), CAST('9999-12-31' AS DATETIME));

--after
SELECT prc.PriceId, prc.ProductId, prc.VatId, prc.PriceWithVat, prc.PriceWithoutVat, prc.DateBegin, prc.DateEnd
FROM dbo.RS_PRICE prc
WHERE prc.ProductId = 1
ORDER BY prc.PriceId;