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

--
-- drop index
--
DROP INDEX FK_RS_PRODUCT_CT_BRAND ON dbo.RS_PRODUCT
GO
IF @@ERROR<>0 OR @@TRANCOUNT=0 BEGIN IF @@TRANCOUNT>0 ROLLBACK SET NOEXEC ON END
GO

--
--drop constraint
--
ALTER TABLE dbo.RS_PRODUCT DROP CONSTRAINT FK_RS_PRODUCT_CT_BRAND
GO
IF @@ERROR<>0 OR @@TRANCOUNT=0 BEGIN IF @@TRANCOUNT>0 ROLLBACK SET NOEXEC ON END
GO


--
--drop column
--
ALTER TABLE dbo.RS_PRODUCT
  DROP COLUMN BrandId
GO
IF @@ERROR<>0 OR @@TRANCOUNT=0 BEGIN IF @@TRANCOUNT>0 ROLLBACK SET NOEXEC ON END
GO

--
--alter v_product
--
ALTER VIEW dbo.V_PRODUCT
AS 
SELECT pr.ProductId, pr.EquipmentId, eq.CategoryId, pr.ModelId, md.BrandId, pr.ImageId, 
	   pr.Name, pr.Descr, pr.Mass, pr.Length, pr.Width, pr.Height, pr.Color, pr.Power, pr.Kit,
	   eq.Name EquipmentName, eq.NameExtra EquipmentNameExtra,
	   ct.Name CategoryName, br.Name BrandName, md.Name ModelName,
	   im.Data, im.MimeType, im.Name ImageName,
	   prc.PriceWithVat, prc.PriceWithoutVat, prc.DateBegin, prc.DateEnd,
	   v.Code VatCode, v.Name VatName, v.Rem VatRem
FROM RS_PRODUCT pr
     JOIN SK_EQUIPMENT eq
	   ON pr.EquipmentId = eq.EquipmentId
     LEFT JOIN CT_CATEGORY ct 
	   ON eq.CategoryId = ct.CategoryId     
     JOIN SK_MODEL md 
	   ON pr.ModelId = md.ModelId
	 JOIN CT_BRAND br 
	   ON md.BrandId = br.BrandId
	 LEFT JOIN CT_IMAGE im
	   ON pr.ImageId = im.ImageId
     LEFT JOIN RS_PRICE prc 
	   ON pr.ProductId = prc.ProductId
          AND GETDATE() BETWEEN prc.DateBegin AND prc.DateEnd
	 LEFT JOIN CT_VAT v 
	   ON prc.VatId = v.VatId
	      AND v.Rem = 0;
GO
IF @@ERROR<>0 OR @@TRANCOUNT=0 BEGIN IF @@TRANCOUNT>0 ROLLBACK SET NOEXEC ON END
GO

--
--update model.name
--
UPDATE dbo.SK_MODEL
SET dbo.SK_MODEL.Name = br.Name + ' ' + dbo.SK_MODEL.Name
FROM (SELECT b.BrandId, b.Name 
      FROM dbo.CT_BRAND b) br
WHERE dbo.SK_MODEL.BrandId = br.BrandId;

--UPDATE md
--SET md.Name = br.Name + ' ' + md.Name
--FROM dbo.SK_MODEL md
--     JOIN dbo.CT_BRAND br 
--	   ON md.BrandId = br.BrandId;

--UPDATE dbo.SK_MODEL
--SET Name = (SELECT DISTINCT br.Name 
--            FROM dbo.CT_BRAND br 
--			WHERE br.BrandId = dbo.SK_MODEL.BrandId) + ' ' + Name;
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