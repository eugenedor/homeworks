USE master;  
GO 
 
IF DB_ID (N'ToolsStore') IS NOT NULL
	DROP DATABASE ToolsStore;
GO


PRINT '<<< CREATE DATABASE TOOLSSTORE >>>'
GO
CREATE DATABASE ToolsStore
ON 
( NAME = ToolsStore,
    FILENAME = 'E:\databases\ToolsStore.mdf',
    SIZE = 10,
    MAXSIZE = 50,
    FILEGROWTH = 5 )
LOG ON
( NAME = ToolsStore_log,
    FILENAME = 'E:\databases\ToolsStore.ldf',
    SIZE = 5MB,
    MAXSIZE = 25MB,
    FILEGROWTH = 5MB ) ;
GO


-- Verify the database files and sizes  
SELECT name, size, size*1.0/128 AS [Size in MBs]   
FROM sys.master_files  
WHERE name = N'ToolsStore';  
GO