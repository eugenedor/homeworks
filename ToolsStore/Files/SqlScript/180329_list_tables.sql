USE ToolsStore;
GO

--1--
SELECT t.* 
FROM sys.tables t
WHERE t.type_desc = 'USER_TABLE'
ORDER BY t.name ASC;

--or--

--2--
SELECT t.* 
FROM sysobjects t 
WHERE t.xtype = 'U'
ORDER BY t.name ASC;

--or--

--3--
SELECT table_name 
FROM information_schema.tables 
ORDER BY table_name ASC;
