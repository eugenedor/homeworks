USE ToolsStore;
go

--UPDATE dbo.SK_EQUIPMENT SET IsActive = 0;


SELECT COUNT(eq.EquipmentId) AS cntAll,
	   COUNT(CASE WHEN pr.EquipmentId IS NOT NULL THEN eq.EquipmentId END) AS cnt1,
       COUNT(CASE WHEN pr.EquipmentId IS NULL THEN eq.EquipmentId END) AS cnt0     
FROM SK_EQUIPMENT eq
     LEFT JOIN (SELECT DISTINCT p.EquipmentId 
	            FROM RS_PRODUCT p
				WHERE p.IsActive = 1) pr
	   ON eq.EquipmentId = pr.EquipmentId;


SELECT COUNT(eq.EquipmentId) AS cntAll,
	   COUNT(CASE WHEN eq.IsActive = 1 THEN eq.EquipmentId END) AS cnt1,
       COUNT(CASE WHEN eq.IsActive = 0 THEN eq.EquipmentId END) AS cnt0
FROM dbo.SK_EQUIPMENT eq;