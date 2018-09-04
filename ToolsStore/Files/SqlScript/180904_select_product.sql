SELECT pr.ProductId, pr.EquipmentId, pr.BrandId, pr.ModelId, pr.ImageId, 
	   pr.Name, pr.Descr, pr.Mass, pr.Length, pr.Width, pr.Height, pr.Color, pr.Power, pr.Kit,
	   eq.CategoryId, eq.Code EquipmentCode, eq.Name EquipmentName, eq.NameExtra EquipmentNameExtra, eq.Ord EquipmentOrd,
	   ct.Code CategoryCode, ct.Name CategoryName, ct.Ord CategoryOrd,
	   br.Code BrandCode, br.Name BrandName,
	   md.Code ModelCode, md.Name ModelName,
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
	 JOIN CT_VAT v 
	   ON prc.VatId = v.VatId