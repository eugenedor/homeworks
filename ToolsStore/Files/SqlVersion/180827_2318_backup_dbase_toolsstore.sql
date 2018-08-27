SET CONCAT_NULL_YIELDS_NULL, ANSI_NULLS, ANSI_PADDING, QUOTED_IDENTIFIER, ANSI_WARNINGS, ARITHABORT, XACT_ABORT ON
SET NUMERIC_ROUNDABORT, IMPLICIT_TRANSACTIONS OFF
GO

--
-- Создать папку для резервной копии базы данных
--
IF OBJECT_ID('xp_create_subdir') IS NOT NULL
  EXEC xp_create_subdir N'E:\backup'
GO

--
-- Создать резервную копию базы данных в файл с именем: <имя_базы_данных>_<гггг>_<мм>_<дд>_<чч>_<мин>.bak
--
DECLARE @db_name SYSNAME
SET @db_name = N'ToolsStore2'

DECLARE @filepath NVARCHAR(4000)
SET @filepath = N'E:\backup\' + @db_name + '_backup_' +                                       /*определить основную часть*/ 
				REPLACE(CONVERT(NVARCHAR(10), GETDATE(), 2), '.', '') + '_' +                 /*добавить дату*/ 
                REPLACE(CONVERT(NVARCHAR(5), GETDATE(), 8), ':', '') + '.bak'                 /*добавить время*/

DECLARE @SQL NVARCHAR(MAX)
SET @SQL = 
    N'BACKUP DATABASE ' + QUOTENAME(@db_name) + ' TO DISK = @filepath WITH INIT' + 
      CASE WHEN EXISTS(
                SELECT value
                FROM sys.configurations
                WHERE name = 'backup compression default'
          )
        THEN ', COMPRESSION'
        ELSE ''
      END

EXEC sys.sp_executesql @SQL, N'@filepath NVARCHAR(4000)', @filepath = @filepath
GO