USE master;  
GO 
 
IF DB_ID (N'ToolsStore2') IS NOT NULL
	DROP DATABASE ToolsStore2;
GO


PRINT '<<< CREATE DATABASE TOOLSSTORE2 >>>'
GO
CREATE DATABASE ToolsStore2
ON 
( NAME = ToolsStore2,
    FILENAME = 'E:\databases\ToolsStore2.mdf',
    SIZE = 10,
    MAXSIZE = 50,
    FILEGROWTH = 5 )
LOG ON
( NAME = ToolsStore2_log,
    FILENAME = 'E:\databases\ToolsStore2.ldf',
    SIZE = 5MB,
    MAXSIZE = 25MB,
    FILEGROWTH = 5MB ) ;
GO


-- Verify the database files and sizes  
SELECT name, size, size*1.0/128 AS [Size in MBs]   
FROM sys.master_files  
WHERE name = N'ToolsStore2';  
GO