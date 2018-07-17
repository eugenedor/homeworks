select m.BrandId, m.ModelId from SK_MODEL m order by m.BrandId, m.ModelId;
select * from RS_PRODUCT p where p.BrandId = 1;
select * from RS_PRODUCT p order by ProductId desc;
select * from RS_PRICE pr order by PriceId desc;

--test1 - bad--
INSERT INTO dbo.RS_PRODUCT (EquipmentId, BrandId, ModelId, Name)
VALUES (1, 2, 1, '');

UPDATE dbo.RS_PRODUCT
SET BrandId = 1, --1
    ModelId = 3  --4
WHERE  ProductId = 4;

--test2 - good--
delete pr
from RS_PRICE pr
where pr.PriceId = 69
      and pr.ProductId = 69;

delete p
from RS_PRODUCT p
where p.ProductId =69
      and p.EquipmentId = 46
      and p.BrandId = 5
	  and p.ModelId = 69;

SET IDENTITY_INSERT dbo.RS_PRODUCT ON;
INSERT INTO dbo.RS_PRODUCT (ProductId, EquipmentId, BrandId, ModelId, Name)
VALUES (69,	46,	5, 69, '«убр Ёксперт (20111-5_z02)');
SET IDENTITY_INSERT dbo.RS_PRODUCT OFF;

SET IDENTITY_INSERT dbo.RS_PRICE ON;
INSERT INTO dbo.RS_PRICE (PriceId, ProductId, VatId, PriceWithVat, PriceWithoutVat, DateBegin, DateEnd) 
VALUES (69, 69, 3, 1616.00, 1369.49, CAST('2018-01-01' AS DATETIME), CAST('9999-12-31' AS DATETIME));
SET IDENTITY_INSERT dbo.RS_PRICE OFF;