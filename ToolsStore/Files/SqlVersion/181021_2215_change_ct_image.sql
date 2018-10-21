USE ToolsStore
GO

IF DB_NAME() <> N'ToolsStore' SET NOEXEC ON
GO

--
-- Change transaction localization level (�������� ������� ����������� ����������)
--
SET TRANSACTION ISOLATION LEVEL SERIALIZABLE
GO

--
-- begin transaction
--
BEGIN TRANSACTION
GO

--
-- add columns
--
ALTER TABLE dbo.CT_IMAGE 
  ADD DateLoad datetime NULL
GO
IF @@ERROR<>0 OR @@TRANCOUNT=0 BEGIN IF @@TRANCOUNT>0 ROLLBACK SET NOEXEC ON END
GO

--
-- update
--
UPDATE dbo.CT_IMAGE
SET DateLoad = CAST('2018-10-21 22:19:55.390' as datetime);
GO
IF @@ERROR<>0 OR @@TRANCOUNT=0 BEGIN IF @@TRANCOUNT>0 ROLLBACK SET NOEXEC ON END
GO

--
-- alter columns
--
ALTER TABLE dbo.CT_IMAGE ALTER COLUMN DateLoad datetime NOT NULL;  
GO
IF @@ERROR<>0 OR @@TRANCOUNT=0 BEGIN IF @@TRANCOUNT>0 ROLLBACK SET NOEXEC ON END
GO

--
-- commit transaction
--
IF @@TRANCOUNT>0 COMMIT TRANSACTION
GO

--
-- set noexec to off (���������� NOEXEC � ��������� off)
--
SET NOEXEC OFF
GO