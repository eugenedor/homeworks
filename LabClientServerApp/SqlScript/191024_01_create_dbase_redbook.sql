USE master;  
GO 
 
IF DB_ID (N'RedBook') IS NOT NULL
	DROP DATABASE RedBook;
GO


PRINT '<<< CREATE DATABASE RedBook >>>'
GO
CREATE DATABASE RedBook
ON 
( NAME = RedBook,
    FILENAME = 'E:\databases\RedBook.mdf',
    SIZE = 10,
    MAXSIZE = 50,
    FILEGROWTH = 5 )
LOG ON
( NAME = RedBook_log,
    FILENAME = 'E:\databases\RedBook.ldf',
    SIZE = 5MB,
    MAXSIZE = 25MB,
    FILEGROWTH = 5MB ) ;
GO


-- Verify the database files and sizes  
SELECT name, size, size*1.0/128 AS [Size in MBs]   
FROM sys.master_files  
WHERE name = N'RedBook';  
GO