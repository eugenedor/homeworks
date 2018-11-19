USE ToolsStore;
GO

----
----Model--
----
--SELECT br.Name as NameBrand, md.Name as NameModel, eq.Name as NameEquipment, ct.Name as NameCategory
--FROM
--	(SELECT m.ModelId, m.BrandId, m.Code, m.Name, 
--		    CAST(SUBSTRING(CAST(m.Code AS NVARCHAR), 1, LEN(CAST(m.Code AS NVARCHAR))-9) AS BIGINT) AS EquipmentId
--	FROM dbo.SK_MODEL m) md
--	left join dbo.CT_BRAND br on md.BrandId = br.BrandId
--	left join dbo.SK_EQUIPMENT eq on md.EquipmentId = eq.EquipmentId
--	left join dbo.CT_CATEGORY ct on eq.CategoryId = ct.CategoryId;


--
--Product
--
select pr.ProductId as ProductId,
       pr.Name as NameProduct,
	   prc.PriceWithVat, 
	   prc.PriceWithoutVat,
	   cast(v.Vat as nvarchar(25)) + '%' as Vat,
       eq.Name as NameEquipment, eq.NameExtra as NameEquipmentExtra,
	   ct.Name as NameCategory, ct.Code as NameCategoryExtra, ct.Ord,
	   br.Name as NameBrand, br.Code as NameBrandExtra,
	   md.Name as NameModel
from
dbo.RS_PRODUCT pr
join dbo.RS_PRICE prc on pr.ProductId = prc.ProductId
                         and getdate() between prc.DateBegin and prc.DateEnd
join dbo.CT_VAT v on prc.VatId = v.VatId
join dbo.SK_EQUIPMENT eq on pr.EquipmentId = eq.EquipmentId
left join dbo.CT_CATEGORY ct on eq.CategoryId = ct.CategoryId
join dbo.CT_BRAND br on pr.BrandId = br.BrandId
join dbo.SK_MODEL md on pr.ModelId = md.ModelId;

--
--Price
--
select prc.PriceId, prc.ProductId, prc.VatId, prc.PriceWithVat, prc.PriceWithoutVat, prc.DateBegin, prc.DateEnd
from dbo.RS_PRICE prc;


----
----Product from model--
----
--select pr.Name as NameProduct,
--       eq.Name as NameEquipment, eq.NameExtra as NameEquipmentExtra,
--	   ct.Name as NameCategory, ct.Code as NameCategoryExtra, ct.Ord,
--	   br.Name as NameBrand, br.Code as NameBrandExtra,
--	   md.Name as NameModel
--from
--(
--SELECT ROW_NUMBER() OVER (order by md.ModelId) as ProductId,
--       md.EquipmentId, 
--	   md.BrandId, 
--	   md.ModelId, 
--	   ISNULL(br.Name + ' ', '') + md.Name as Name
--FROM
--	(SELECT m.ModelId, 
--	        m.BrandId, 
--			m.Name, 
--		    CAST(SUBSTRING(CAST(m.Code AS NVARCHAR), 1, LEN(CAST(m.Code AS NVARCHAR))-9) AS BIGINT) AS EquipmentId
--	FROM dbo.SK_MODEL m) md
--	     left join dbo.CT_BRAND br on md.BrandId = br.BrandId
--) pr
--left join dbo.SK_EQUIPMENT eq on pr.EquipmentId = eq.EquipmentId
--left join dbo.CT_CATEGORY ct on eq.CategoryId = ct.CategoryId
--left join dbo.CT_BRAND br on pr.BrandId = br.BrandId
--left join dbo.SK_MODEL md on pr.ModelId = md.ModelId;