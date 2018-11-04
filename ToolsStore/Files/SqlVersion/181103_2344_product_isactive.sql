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
--rs_product add isactive null
--
ALTER TABLE dbo.RS_PRODUCT 
  ADD IsActive BIT NULL;
GO
IF @@ERROR<>0 OR @@TRANCOUNT=0 BEGIN IF @@TRANCOUNT>0 ROLLBACK SET NOEXEC ON END
GO

--
--rs_product.isactive = 0
--
UPDATE dbo.RS_PRODUCT
SET IsActive = 1;
GO
IF @@ERROR<>0 OR @@TRANCOUNT=0 BEGIN IF @@TRANCOUNT>0 ROLLBACK SET NOEXEC ON END
GO

--
--rs_product.isactive not null
--
ALTER TABLE dbo.RS_PRODUCT 
  ALTER COLUMN IsActive BIT NOT NULL; 
GO
IF @@ERROR<>0 OR @@TRANCOUNT=0 BEGIN IF @@TRANCOUNT>0 ROLLBACK SET NOEXEC ON END
GO

--
-- procedure sp_refresh_equipment_isactive
--
ALTER PROCEDURE dbo.SP_RFR_EQUIPMENT_ISACTIVE
AS
BEGIN
	UPDATE eq
	SET eq.IsActive = CASE WHEN pr.EquipmentId IS NOT NULL THEN 1 ELSE 0 END
	FROM dbo.SK_EQUIPMENT eq
		 LEFT JOIN (SELECT DISTINCT p.EquipmentId 
					FROM dbo.RS_PRODUCT p
					WHERE p.IsActive = 1) pr
		   ON eq.EquipmentId = pr.EquipmentId;

END
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