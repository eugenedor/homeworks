USE ToolsStore
GO

SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO


CREATE VIEW dbo.V_PRODUCT
AS 
SELECT pr.ProductId, pr.EquipmentId, eq.CategoryId, pr.BrandId, pr.ModelId, pr.ImageId, 
	   pr.Name, pr.Descr, pr.Mass, pr.Length, pr.Width, pr.Height, pr.Color, pr.Power, pr.Kit,
	   eq.Name EquipmentName, eq.NameExtra EquipmentNameExtra,
	   ct.Name CategoryName, br.Name BrandName, md.Name ModelName,
	   im.Data, im.MimeType, im.Name ImageName,
	   prc.PriceWithVat, prc.PriceWithoutVat, prc.DateBegin, prc.DateEnd,
	   v.Vat, v.Name VatName, v.Rem VatRem
FROM RS_PRODUCT pr
     JOIN SK_EQUIPMENT eq
	   ON pr.EquipmentId = eq.EquipmentId
     LEFT JOIN CT_CATEGORY ct 
	   ON eq.CategoryId = ct.CategoryId
     JOIN CT_BRAND br 
	   ON pr.BrandId = br.BrandId
     JOIN SK_MODEL md 
	   ON pr.ModelId = md.ModelId
	 LEFT JOIN CT_IMAGE im
	   ON pr.ImageId = im.ImageId
     LEFT JOIN RS_PRICE prc 
	   ON pr.ProductId = prc.ProductId
          AND GETDATE() BETWEEN prc.DateBegin AND prc.DateEnd
	 LEFT JOIN CT_VAT v 
	   ON prc.VatId = v.VatId
	      AND v.Rem = 0;

GO