ALTER TABLE dbo.SK_EQUIPMENT 
  ADD IsActive BIT NULL;

UPDATE dbo.SK_EQUIPMENT
SET IsActive = 0;

ALTER TABLE dbo.SK_EQUIPMENT 
  ALTER COLUMN IsActive BIT NOT NULL; 

UPDATE eq
SET eq.IsActive = CASE WHEN pr.EquipmentId IS NOT NULL THEN 1 ELSE 0 END
FROM dbo.SK_EQUIPMENT eq
     LEFT JOIN (SELECT DISTINCT p.EquipmentId 
	            FROM dbo.RS_PRODUCT p) pr
	   ON eq.EquipmentId = pr.EquipmentId;


--
--select equipment--
--
SELECT COUNT(eq.EquipmentId) AS cntAll,
	   COUNT(CASE WHEN pr.EquipmentId IS NOT NULL THEN eq.EquipmentId END) AS cnt1,
       COUNT(CASE WHEN pr.EquipmentId IS NULL THEN eq.EquipmentId END) AS cnt0     
FROM SK_EQUIPMENT eq
     LEFT JOIN (SELECT DISTINCT p.EquipmentId 
	            FROM RS_PRODUCT p) pr
	   ON eq.EquipmentId = pr.EquipmentId;

SELECT COUNT(eq.EquipmentId) AS cntAll,
	   COUNT(CASE WHEN eq.IsActive = 1 THEN eq.EquipmentId END) AS cnt1,
       COUNT(CASE WHEN eq.IsActive = 0 THEN eq.EquipmentId END) AS cnt0
FROM dbo.SK_EQUIPMENT eq;


SELECT eq.* 
FROM SK_EQUIPMENT eq
     LEFT JOIN (SELECT DISTINCT p.EquipmentId 
	            FROM RS_PRODUCT p) pr
	   ON eq.EquipmentId = pr.EquipmentId
WHERE pr.EquipmentId IS NULL;

SELECT eq.*
FROM dbo.SK_EQUIPMENT eq
WHERE eq.IsActive = 0;


SELECT DISTINCT eq.CategoryId
FROM dbo.SK_EQUIPMENT eq
WHERE eq.IsActive = 1;

--
--select category--
--
SELECT COUNT(ct.CategoryId) as cntAll,
	   COUNT(CASE WHEN eq.CategoryId IS NOT NULL THEN ct.CategoryId END) AS cnt1,
       COUNT(CASE WHEN eq.CategoryId IS NULL THEN ct.CategoryId END) AS cnt0      
FROM dbo.CT_CATEGORY ct
     LEFT JOIN (SELECT DISTINCT e.CategoryId 
	            FROM dbo.SK_EQUIPMENT e
				WHERE e.IsActive = 1) eq
	   ON ct.CategoryId = eq.CategoryId


SELECT ct.*  
FROM dbo.CT_CATEGORY ct
     LEFT JOIN (SELECT DISTINCT e.CategoryId 
	            FROM dbo.SK_EQUIPMENT e
				WHERE e.IsActive = 1) eq
	   ON ct.CategoryId = eq.CategoryId
WHERE eq.CategoryId IS NULL;


--
-- procedure sp_upd_equipment_isactive
--
CREATE PROCEDURE dbo.SP_UPD_EQUIPMENT_ISACTIVE
AS
BEGIN
	UPDATE eq
	SET eq.IsActive = CASE WHEN pr.EquipmentId IS NOT NULL THEN 1 ELSE 0 END
	FROM dbo.SK_EQUIPMENT eq
		 LEFT JOIN (SELECT DISTINCT p.EquipmentId 
					FROM dbo.RS_PRODUCT p) pr
		   ON eq.EquipmentId = pr.EquipmentId;

END