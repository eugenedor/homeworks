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
--sk_equipment add isactive null
--
ALTER TABLE dbo.SK_EQUIPMENT 
  ADD IsActive BIT NULL;
GO
IF @@ERROR<>0 OR @@TRANCOUNT=0 BEGIN IF @@TRANCOUNT>0 ROLLBACK SET NOEXEC ON END
GO

--
--sk_equipment.isactive = 0
--
UPDATE dbo.SK_EQUIPMENT
SET IsActive = 0;
GO
IF @@ERROR<>0 OR @@TRANCOUNT=0 BEGIN IF @@TRANCOUNT>0 ROLLBACK SET NOEXEC ON END
GO

--
--sk_equipment.isactive not null
--
ALTER TABLE dbo.SK_EQUIPMENT 
  ALTER COLUMN IsActive BIT NOT NULL; 
GO
IF @@ERROR<>0 OR @@TRANCOUNT=0 BEGIN IF @@TRANCOUNT>0 ROLLBACK SET NOEXEC ON END
GO

--
-- procedure sp_refresh_equipment_isactive
--
CREATE PROCEDURE dbo.SP_RFR_EQUIPMENT_ISACTIVE
AS
BEGIN
	UPDATE eq
	SET eq.IsActive = CASE WHEN pr.EquipmentId IS NOT NULL THEN 1 ELSE 0 END
	FROM dbo.SK_EQUIPMENT eq
		 LEFT JOIN (SELECT DISTINCT p.EquipmentId 
					FROM dbo.RS_PRODUCT p) pr
		   ON eq.EquipmentId = pr.EquipmentId;

END
GO
IF @@ERROR<>0 OR @@TRANCOUNT=0 BEGIN IF @@TRANCOUNT>0 ROLLBACK SET NOEXEC ON END
GO

--
-- procedure sp_refresh_equipment_isactive
--
CREATE PROCEDURE dbo.SP_SET_EQUIPMENT_ISACTIVE
	@isactive bit
AS
BEGIN
	UPDATE dbo.SK_EQUIPMENT
	SET IsActive = @isactive;
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