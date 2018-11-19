USE ToolsStore;
GO

PRINT '<<< INSERT RS_PRODUCT >>>'
GO
SET IDENTITY_INSERT dbo.RS_PRODUCT ON;

INSERT INTO dbo.RS_PRODUCT (ProductId, EquipmentId, BrandId, ModelId, Name)
SELECT ROW_NUMBER() OVER (order by md.ModelId) as ProductId,
       md.EquipmentId, 
	   md.BrandId, 
	   md.ModelId, 
	   ISNULL(br.Name + ' ', '') + md.Name as Name
FROM
	(SELECT m.ModelId, 
	        m.BrandId, 
			m.Name, 
		    CAST(SUBSTRING(CAST(m.Code AS NVARCHAR), 1, LEN(CAST(m.Code AS NVARCHAR))-9) AS BIGINT) AS EquipmentId
	FROM dbo.SK_MODEL m
	WHERE m.ModelId != 0) md
	     left join dbo.CT_BRAND br on md.BrandId = br.BrandId;

SET IDENTITY_INSERT dbo.RS_PRODUCT OFF;
PRINT ''
GO