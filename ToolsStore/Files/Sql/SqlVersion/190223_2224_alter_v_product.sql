USE ToolsStore
GO

ALTER VIEW dbo.V_PRODUCT
AS 
SELECT pr.ProductId, pr.EquipmentId, eq.CategoryId, pr.ModelId, md.BrandId, pr.ImageId, 
	   pr.Name, pr.Descr, pr.Mass, pr.Length, pr.Width, pr.Height, pr.Color, pr.Power, pr.Kit,
	   eq.Name EquipmentName, eq.NameExtra EquipmentNameExtra,
	   ct.Name CategoryName, br.Name BrandName, md.Name ModelName,
	   im.Data, im.MimeType, im.FileName ImageName,
	   prc.PriceWithVat, prc.PriceWithoutVat, prc.DateBegin, prc.DateEnd,
	   v.Code VatCode, v.Name VatName, v.IsActive VatIsActive
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
	      AND v.IsActive = 1;
GO


