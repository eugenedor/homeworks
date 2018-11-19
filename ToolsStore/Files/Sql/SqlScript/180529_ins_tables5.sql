USE ToolsStore;
GO

PRINT '<<< INSERT RS_PRICE >>>'
GO
SET IDENTITY_INSERT dbo.RS_PRICE ON;

DECLARE @vatId BIGINT,
        @dateBegin DATETIME,
		@dateEnd DATETIME;

SELECT @vatId = v.VatId 
FROM CT_VAT v 
WHERE v.Vat = 18;

SELECT @dateBegin = CAST('2018-01-01' AS DATETIME), 
       @dateEnd = CAST('9999-12-31' AS DATETIME);

SELECT @vatId AS vatId, @dateBegin AS dateBegin, @dateEnd AS dateEnd

INSERT INTO dbo.RS_PRICE (PriceId, ProductId, VatId, PriceWithVat, PriceWithoutVat, DateBegin, DateEnd) VALUES (1, 1, @vatId, 4190.00, 3550.85, @dateBegin, @dateEnd);
INSERT INTO dbo.RS_PRICE (PriceId, ProductId, VatId, PriceWithVat, PriceWithoutVat, DateBegin, DateEnd) VALUES (2, 2, @vatId, 1648.00, 1396.61, @dateBegin, @dateEnd);
INSERT INTO dbo.RS_PRICE (PriceId, ProductId, VatId, PriceWithVat, PriceWithoutVat, DateBegin, DateEnd) VALUES (3, 3, @vatId, 4804.00, 4071.19, @dateBegin, @dateEnd);
INSERT INTO dbo.RS_PRICE (PriceId, ProductId, VatId, PriceWithVat, PriceWithoutVat, DateBegin, DateEnd) VALUES (4, 4, @vatId, 8990.00, 7618.64, @dateBegin, @dateEnd);
INSERT INTO dbo.RS_PRICE (PriceId, ProductId, VatId, PriceWithVat, PriceWithoutVat, DateBegin, DateEnd) VALUES (5, 5, @vatId, 10179.00, 8626.27, @dateBegin, @dateEnd);
INSERT INTO dbo.RS_PRICE (PriceId, ProductId, VatId, PriceWithVat, PriceWithoutVat, DateBegin, DateEnd) VALUES (6, 6, @vatId, 6590.00, 5584.75, @dateBegin, @dateEnd);
INSERT INTO dbo.RS_PRICE (PriceId, ProductId, VatId, PriceWithVat, PriceWithoutVat, DateBegin, DateEnd) VALUES (7, 7, @vatId, 6962.00, 5900.00, @dateBegin, @dateEnd);
INSERT INTO dbo.RS_PRICE (PriceId, ProductId, VatId, PriceWithVat, PriceWithoutVat, DateBegin, DateEnd) VALUES (8, 8, @vatId, 13590.00, 11516.95, @dateBegin, @dateEnd);
INSERT INTO dbo.RS_PRICE (PriceId, ProductId, VatId, PriceWithVat, PriceWithoutVat, DateBegin, DateEnd) VALUES (9, 9, @vatId, 2294.00, 1944.07, @dateBegin, @dateEnd);
INSERT INTO dbo.RS_PRICE (PriceId, ProductId, VatId, PriceWithVat, PriceWithoutVat, DateBegin, DateEnd) VALUES (10, 10, @vatId, 2675.00, 2266.95, @dateBegin, @dateEnd);
INSERT INTO dbo.RS_PRICE (PriceId, ProductId, VatId, PriceWithVat, PriceWithoutVat, DateBegin, DateEnd) VALUES (11, 11, @vatId, 9888.00, 8379.66, @dateBegin, @dateEnd);
INSERT INTO dbo.RS_PRICE (PriceId, ProductId, VatId, PriceWithVat, PriceWithoutVat, DateBegin, DateEnd) VALUES (12, 12, @vatId, 1500.00, 1271.19, @dateBegin, @dateEnd);
INSERT INTO dbo.RS_PRICE (PriceId, ProductId, VatId, PriceWithVat, PriceWithoutVat, DateBegin, DateEnd) VALUES (13, 13, @vatId, 7990.00, 6771.19, @dateBegin, @dateEnd);
INSERT INTO dbo.RS_PRICE (PriceId, ProductId, VatId, PriceWithVat, PriceWithoutVat, DateBegin, DateEnd) VALUES (14, 14, @vatId, 2890.00, 2449.15, @dateBegin, @dateEnd);
INSERT INTO dbo.RS_PRICE (PriceId, ProductId, VatId, PriceWithVat, PriceWithoutVat, DateBegin, DateEnd) VALUES (15, 15, @vatId, 8990.00, 7618.64, @dateBegin, @dateEnd);
INSERT INTO dbo.RS_PRICE (PriceId, ProductId, VatId, PriceWithVat, PriceWithoutVat, DateBegin, DateEnd) VALUES (16, 16, @vatId, 8990.00, 7618.64, @dateBegin, @dateEnd);
INSERT INTO dbo.RS_PRICE (PriceId, ProductId, VatId, PriceWithVat, PriceWithoutVat, DateBegin, DateEnd) VALUES (17, 17, @vatId, 2960.00, 2508.47, @dateBegin, @dateEnd);
INSERT INTO dbo.RS_PRICE (PriceId, ProductId, VatId, PriceWithVat, PriceWithoutVat, DateBegin, DateEnd) VALUES (18, 18, @vatId, 5299.00, 4490.68, @dateBegin, @dateEnd);
INSERT INTO dbo.RS_PRICE (PriceId, ProductId, VatId, PriceWithVat, PriceWithoutVat, DateBegin, DateEnd) VALUES (19, 19, @vatId, 1686.00, 1428.81, @dateBegin, @dateEnd);
INSERT INTO dbo.RS_PRICE (PriceId, ProductId, VatId, PriceWithVat, PriceWithoutVat, DateBegin, DateEnd) VALUES (20, 20, @vatId, 3999.00, 3388.98, @dateBegin, @dateEnd);
INSERT INTO dbo.RS_PRICE (PriceId, ProductId, VatId, PriceWithVat, PriceWithoutVat, DateBegin, DateEnd) VALUES (21, 21, @vatId, 4716.00, 3996.61, @dateBegin, @dateEnd);
INSERT INTO dbo.RS_PRICE (PriceId, ProductId, VatId, PriceWithVat, PriceWithoutVat, DateBegin, DateEnd) VALUES (22, 22, @vatId, 5099.00, 4321.19, @dateBegin, @dateEnd);
INSERT INTO dbo.RS_PRICE (PriceId, ProductId, VatId, PriceWithVat, PriceWithoutVat, DateBegin, DateEnd) VALUES (23, 23, @vatId, 5390.00, 4567.80, @dateBegin, @dateEnd);
INSERT INTO dbo.RS_PRICE (PriceId, ProductId, VatId, PriceWithVat, PriceWithoutVat, DateBegin, DateEnd) VALUES (24, 24, @vatId, 6300.00, 5338.98, @dateBegin, @dateEnd);
INSERT INTO dbo.RS_PRICE (PriceId, ProductId, VatId, PriceWithVat, PriceWithoutVat, DateBegin, DateEnd) VALUES (25, 25, @vatId, 8149.00, 6905.93, @dateBegin, @dateEnd);
INSERT INTO dbo.RS_PRICE (PriceId, ProductId, VatId, PriceWithVat, PriceWithoutVat, DateBegin, DateEnd) VALUES (26, 26, @vatId, 6400.00, 5423.73, @dateBegin, @dateEnd);
INSERT INTO dbo.RS_PRICE (PriceId, ProductId, VatId, PriceWithVat, PriceWithoutVat, DateBegin, DateEnd) VALUES (27, 27, @vatId, 3509.00, 2973.73, @dateBegin, @dateEnd);
INSERT INTO dbo.RS_PRICE (PriceId, ProductId, VatId, PriceWithVat, PriceWithoutVat, DateBegin, DateEnd) VALUES (28, 28, @vatId, 3000.00, 2542.37, @dateBegin, @dateEnd);
INSERT INTO dbo.RS_PRICE (PriceId, ProductId, VatId, PriceWithVat, PriceWithoutVat, DateBegin, DateEnd) VALUES (29, 29, @vatId, 11090.00, 9398.31, @dateBegin, @dateEnd);
INSERT INTO dbo.RS_PRICE (PriceId, ProductId, VatId, PriceWithVat, PriceWithoutVat, DateBegin, DateEnd) VALUES (30, 30, @vatId, 4059.00, 3439.83, @dateBegin, @dateEnd);
INSERT INTO dbo.RS_PRICE (PriceId, ProductId, VatId, PriceWithVat, PriceWithoutVat, DateBegin, DateEnd) VALUES (31, 31, @vatId, 7790.00, 6601.69, @dateBegin, @dateEnd);
INSERT INTO dbo.RS_PRICE (PriceId, ProductId, VatId, PriceWithVat, PriceWithoutVat, DateBegin, DateEnd) VALUES (32, 32, @vatId, 4260.00, 3610.17, @dateBegin, @dateEnd);
INSERT INTO dbo.RS_PRICE (PriceId, ProductId, VatId, PriceWithVat, PriceWithoutVat, DateBegin, DateEnd) VALUES (33, 33, @vatId, 5806.00, 4920.34, @dateBegin, @dateEnd);
INSERT INTO dbo.RS_PRICE (PriceId, ProductId, VatId, PriceWithVat, PriceWithoutVat, DateBegin, DateEnd) VALUES (34, 34, @vatId, 52.00, 44.07, @dateBegin, @dateEnd);
INSERT INTO dbo.RS_PRICE (PriceId, ProductId, VatId, PriceWithVat, PriceWithoutVat, DateBegin, DateEnd) VALUES (35, 35, @vatId, 505.00, 427.97, @dateBegin, @dateEnd);
INSERT INTO dbo.RS_PRICE (PriceId, ProductId, VatId, PriceWithVat, PriceWithoutVat, DateBegin, DateEnd) VALUES (36, 36, @vatId, 330.00, 279.66, @dateBegin, @dateEnd);
INSERT INTO dbo.RS_PRICE (PriceId, ProductId, VatId, PriceWithVat, PriceWithoutVat, DateBegin, DateEnd) VALUES (37, 37, @vatId, 570.00, 483.05, @dateBegin, @dateEnd);
INSERT INTO dbo.RS_PRICE (PriceId, ProductId, VatId, PriceWithVat, PriceWithoutVat, DateBegin, DateEnd) VALUES (38, 38, @vatId, 133.00, 112.71, @dateBegin, @dateEnd);
INSERT INTO dbo.RS_PRICE (PriceId, ProductId, VatId, PriceWithVat, PriceWithoutVat, DateBegin, DateEnd) VALUES (39, 39, @vatId, 178.00, 150.85, @dateBegin, @dateEnd);
INSERT INTO dbo.RS_PRICE (PriceId, ProductId, VatId, PriceWithVat, PriceWithoutVat, DateBegin, DateEnd) VALUES (40, 40, @vatId, 59.00, 50.00, @dateBegin, @dateEnd);
INSERT INTO dbo.RS_PRICE (PriceId, ProductId, VatId, PriceWithVat, PriceWithoutVat, DateBegin, DateEnd) VALUES (41, 41, @vatId, 700.00, 593.22, @dateBegin, @dateEnd);
INSERT INTO dbo.RS_PRICE (PriceId, ProductId, VatId, PriceWithVat, PriceWithoutVat, DateBegin, DateEnd) VALUES (42, 42, @vatId, 553.00, 468.64, @dateBegin, @dateEnd);
INSERT INTO dbo.RS_PRICE (PriceId, ProductId, VatId, PriceWithVat, PriceWithoutVat, DateBegin, DateEnd) VALUES (43, 43, @vatId, 1188.00, 1006.78, @dateBegin, @dateEnd);
INSERT INTO dbo.RS_PRICE (PriceId, ProductId, VatId, PriceWithVat, PriceWithoutVat, DateBegin, DateEnd) VALUES (44, 44, @vatId, 977.00, 827.97, @dateBegin, @dateEnd);
INSERT INTO dbo.RS_PRICE (PriceId, ProductId, VatId, PriceWithVat, PriceWithoutVat, DateBegin, DateEnd) VALUES (45, 45, @vatId, 290, 245.76, @dateBegin, @dateEnd);
INSERT INTO dbo.RS_PRICE (PriceId, ProductId, VatId, PriceWithVat, PriceWithoutVat, DateBegin, DateEnd) VALUES (46, 46, @vatId, 254.00, 215.25, @dateBegin, @dateEnd);
INSERT INTO dbo.RS_PRICE (PriceId, ProductId, VatId, PriceWithVat, PriceWithoutVat, DateBegin, DateEnd) VALUES (47, 47, @vatId, 700.00, 593.22, @dateBegin, @dateEnd);
INSERT INTO dbo.RS_PRICE (PriceId, ProductId, VatId, PriceWithVat, PriceWithoutVat, DateBegin, DateEnd) VALUES (48, 48, @vatId, 977.00, 827.97, @dateBegin, @dateEnd);
INSERT INTO dbo.RS_PRICE (PriceId, ProductId, VatId, PriceWithVat, PriceWithoutVat, DateBegin, DateEnd) VALUES (49, 49, @vatId, 1545.00, 1309.32, @dateBegin, @dateEnd);
INSERT INTO dbo.RS_PRICE (PriceId, ProductId, VatId, PriceWithVat, PriceWithoutVat, DateBegin, DateEnd) VALUES (50, 50, @vatId, 1109.00, 939.83, @dateBegin, @dateEnd);
INSERT INTO dbo.RS_PRICE (PriceId, ProductId, VatId, PriceWithVat, PriceWithoutVat, DateBegin, DateEnd) VALUES (51, 51, @vatId, 1121.00, 950.00, @dateBegin, @dateEnd);
INSERT INTO dbo.RS_PRICE (PriceId, ProductId, VatId, PriceWithVat, PriceWithoutVat, DateBegin, DateEnd) VALUES (52, 52, @vatId, 981.00, 831.36, @dateBegin, @dateEnd);
INSERT INTO dbo.RS_PRICE (PriceId, ProductId, VatId, PriceWithVat, PriceWithoutVat, DateBegin, DateEnd) VALUES (53, 53, @vatId, 376.00, 318.64, @dateBegin, @dateEnd);
INSERT INTO dbo.RS_PRICE (PriceId, ProductId, VatId, PriceWithVat, PriceWithoutVat, DateBegin, DateEnd) VALUES (54, 54, @vatId, 483.00, 409.32, @dateBegin, @dateEnd);
INSERT INTO dbo.RS_PRICE (PriceId, ProductId, VatId, PriceWithVat, PriceWithoutVat, DateBegin, DateEnd) VALUES (55, 55, @vatId, 929.00, 787.29, @dateBegin, @dateEnd);
INSERT INTO dbo.RS_PRICE (PriceId, ProductId, VatId, PriceWithVat, PriceWithoutVat, DateBegin, DateEnd) VALUES (56, 56, @vatId, 420.00, 355.93, @dateBegin, @dateEnd);
INSERT INTO dbo.RS_PRICE (PriceId, ProductId, VatId, PriceWithVat, PriceWithoutVat, DateBegin, DateEnd) VALUES (57, 57, @vatId, 381.00, 322.88, @dateBegin, @dateEnd);
INSERT INTO dbo.RS_PRICE (PriceId, ProductId, VatId, PriceWithVat, PriceWithoutVat, DateBegin, DateEnd) VALUES (58, 58, @vatId, 208.00, 176.27, @dateBegin, @dateEnd);
INSERT INTO dbo.RS_PRICE (PriceId, ProductId, VatId, PriceWithVat, PriceWithoutVat, DateBegin, DateEnd) VALUES (59, 59, @vatId, 1073.00, 909.32, @dateBegin, @dateEnd);
INSERT INTO dbo.RS_PRICE (PriceId, ProductId, VatId, PriceWithVat, PriceWithoutVat, DateBegin, DateEnd) VALUES (60, 60, @vatId, 1049.00, 888.98, @dateBegin, @dateEnd);
INSERT INTO dbo.RS_PRICE (PriceId, ProductId, VatId, PriceWithVat, PriceWithoutVat, DateBegin, DateEnd) VALUES (61, 61, @vatId, 623.00, 527.97, @dateBegin, @dateEnd);
INSERT INTO dbo.RS_PRICE (PriceId, ProductId, VatId, PriceWithVat, PriceWithoutVat, DateBegin, DateEnd) VALUES (62, 62, @vatId, 207.00, 175.42, @dateBegin, @dateEnd);
INSERT INTO dbo.RS_PRICE (PriceId, ProductId, VatId, PriceWithVat, PriceWithoutVat, DateBegin, DateEnd) VALUES (63, 63, @vatId, 194.00, 164.41, @dateBegin, @dateEnd);
INSERT INTO dbo.RS_PRICE (PriceId, ProductId, VatId, PriceWithVat, PriceWithoutVat, DateBegin, DateEnd) VALUES (64, 64, @vatId, 619.00, 524.58, @dateBegin, @dateEnd);
INSERT INTO dbo.RS_PRICE (PriceId, ProductId, VatId, PriceWithVat, PriceWithoutVat, DateBegin, DateEnd) VALUES (65, 65, @vatId, 1491.00, 1263.56, @dateBegin, @dateEnd);
INSERT INTO dbo.RS_PRICE (PriceId, ProductId, VatId, PriceWithVat, PriceWithoutVat, DateBegin, DateEnd) VALUES (66, 66, @vatId, 1031.00, 873.73, @dateBegin, @dateEnd);
INSERT INTO dbo.RS_PRICE (PriceId, ProductId, VatId, PriceWithVat, PriceWithoutVat, DateBegin, DateEnd) VALUES (67, 67, @vatId, 447.00, 378.81, @dateBegin, @dateEnd);
INSERT INTO dbo.RS_PRICE (PriceId, ProductId, VatId, PriceWithVat, PriceWithoutVat, DateBegin, DateEnd) VALUES (68, 68, @vatId, 788.00, 667.80, @dateBegin, @dateEnd);
INSERT INTO dbo.RS_PRICE (PriceId, ProductId, VatId, PriceWithVat, PriceWithoutVat, DateBegin, DateEnd) VALUES (69, 69, @vatId, 1616.00, 1369.49, @dateBegin, @dateEnd);


SET IDENTITY_INSERT dbo.RS_PRICE OFF;
PRINT ''
GO

--delete from dbo.RS_PRICE;