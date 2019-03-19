USE ToolsStore;
GO


UPDATE RS_PRICE
SET VatId     = (SELECT V.VATID FROM CT_VAT V WHERE V.CODE = 20),
	PriceWithVat = 4990.00,
	PriceWithoutVat = dbo.FN_GET_PR_PRVAT(CAST(4990.00 AS DECIMAL(17,2)), 20),
    DateBegin = CONVERT(DATETIME, CONVERT(NVARCHAR(4), YEAR(DateBegin)+1) + '0101', 112), --DATEADD(dd, DATEDIFF(dd, DateBegin, CONVERT(DATETIME, CONVERT(NVARCHAR(4), YEAR(DateBegin)+1) + '0101', 112)), DateBegin)
    DateEnd   = CONVERT(DATETIME, CONVERT(NVARCHAR(12), DateEnd, 112), 112)
WHERE PriceId = 70;
GO


UPDATE RS_PRICE
SET DateEnd = DATEADD(dd, 
	          DATEDIFF(dd, DateEnd, CONVERT(DATETIME, CONVERT(NVARCHAR(4), YEAR(DateEnd)+1) + '0101', 112))-1, 
			  CONVERT(DATETIME, CONVERT(NVARCHAR(12), DateEnd, 112), 112))
WHERE PriceId = 1;
GO


UPDATE RS_PRICE
SET DateEnd =  DATEADD(dd, -1, CONVERT(DATETIME, CONVERT(NVARCHAR(4), YEAR(DateBegin)+1) + '0101', 112))
WHERE PriceId IN (2, 4, 8, 16, 32, 64);
GO


INSERT INTO RS_PRICE (ProductId, VatId, PriceWithVat, PriceWithoutVat, DateBegin, DateEnd)
SELECT 2 AS ProductId, 
       (SELECT V.VATID FROM CT_VAT V WHERE V.CODE = 20) AS VatId, 
	   2449.00 AS PriceWithVat, 
	   dbo.FN_GET_PR_PRVAT(CAST(2449.00 AS DECIMAL(17,2)), 20) AS PriceWithoutVat, 
	   CONVERT(DATETIME, '20190101', 112) AS DateBegin, 
	   CONVERT(DATETIME, '99991231', 112) AS DateEnd
GO


INSERT INTO RS_PRICE (ProductId, VatId, PriceWithVat, PriceWithoutVat, DateBegin, DateEnd)
SELECT 4 AS ProductId, 
       (SELECT V.VATID FROM CT_VAT V WHERE V.CODE = 20) AS VatId, 
	   9790.00 AS PriceWithVat, 
	   dbo.FN_GET_PR_PRVAT(CAST(9790.00 AS DECIMAL(17,2)), 20) AS PriceWithoutVat, 
	   CONVERT(DATETIME, '20190101', 112) AS DateBegin, 
	   CONVERT(DATETIME, '99991231', 112) AS DateEnd
GO


INSERT INTO RS_PRICE (ProductId, VatId, PriceWithVat, PriceWithoutVat, DateBegin, DateEnd)
SELECT 8 AS ProductId, 
       (SELECT V.VATID FROM CT_VAT V WHERE V.CODE = 20) AS VatId, 
	   15590.00 AS PriceWithVat, 
	   dbo.FN_GET_PR_PRVAT(CAST(15590.00 AS DECIMAL(17,2)), 20) AS PriceWithoutVat, 
	   CONVERT(DATETIME, '20190101', 112) AS DateBegin, 
	   CONVERT(DATETIME, '99991231', 112) AS DateEnd
GO


INSERT INTO RS_PRICE (ProductId, VatId, PriceWithVat, PriceWithoutVat, DateBegin, DateEnd)
SELECT 16 AS ProductId, 
       (SELECT V.VATID FROM CT_VAT V WHERE V.CODE = 20) AS VatId, 
	   11290.00 AS PriceWithVat, 
	   dbo.FN_GET_PR_PRVAT(CAST(11290.00 AS DECIMAL(17,2)), 20) AS PriceWithoutVat, 
	   CONVERT(DATETIME, '20190101', 112) AS DateBegin, 
	   CONVERT(DATETIME, '99991231', 112) AS DateEnd
GO


INSERT INTO RS_PRICE (ProductId, VatId, PriceWithVat, PriceWithoutVat, DateBegin, DateEnd)
SELECT 32 AS ProductId, 
       (SELECT V.VATID FROM CT_VAT V WHERE V.CODE = 20) AS VatId, 
	   5660.00 AS PriceWithVat, 
	   dbo.FN_GET_PR_PRVAT(CAST(5660.00 AS DECIMAL(17,2)), 20) AS PriceWithoutVat, 
	   CONVERT(DATETIME, '20190101', 112) AS DateBegin, 
	   CONVERT(DATETIME, '99991231', 112) AS DateEnd
GO


INSERT INTO RS_PRICE (ProductId, VatId, PriceWithVat, PriceWithoutVat, DateBegin, DateEnd)
SELECT 64 AS ProductId, 
       (SELECT V.VATID FROM CT_VAT V WHERE V.CODE = 20) AS VatId, 
	   749.00 AS PriceWithVat, 
	   dbo.FN_GET_PR_PRVAT(CAST(749.00 AS DECIMAL(17,2)), 20) AS PriceWithoutVat, 
	   CONVERT(DATETIME, '20190101', 112) AS DateBegin, 
	   CONVERT(DATETIME, '99991231', 112) AS DateEnd
GO


UPDATE RS_PRICE
SET VatId = (SELECT V.VATID FROM CT_VAT V WHERE V.CODE = 20),
    PriceWithVat = PriceWithVat * 1.25,
	PriceWithoutVat = dbo.FN_GET_PR_PRVAT(PriceWithVat * 1.25, 20),
	DateBegin = CONVERT(DATETIME, '20190101', 112), 
    DateEnd = CONVERT(DATETIME, '99991231', 112)
WHERE RS_PRICE.ProductId IN (SELECT p.ProductId
							FROM RS_PRICE p
							GROUP BY p.ProductId
							HAVING COUNT(p.PriceId) = 1);
GO