--
--sysobjects + syscomments
--

--dor--	  
SELECT DISTINCT o.id,
                o.name AS ObjectName,
                o.type, o.xtype,
				CASE o.xtype
					WHEN 'C' THEN 'CHECK constraint'
					WHEN 'D' THEN 'Default or DEFAULT constraint'
					WHEN 'F' THEN 'FOREIGN KEY constraint'
					WHEN 'FN' THEN 'Scalar function'
					WHEN 'IF' THEN 'In-lined table-function'
					WHEN 'K' THEN 'PRIMARY KEY or UNIQUE constraint'
					WHEN 'L' THEN 'Log'
					WHEN 'P' THEN 'Stored procedure'
					WHEN 'R' THEN 'Rule'
					WHEN 'RF' THEN 'Replication filter stored procedure'
					WHEN 'S' THEN 'System table'
					WHEN 'TF' THEN 'Table function'
					WHEN 'TR' THEN 'Trigger'
					WHEN 'U' THEN 'User table'
					WHEN 'V' THEN 'View'
					WHEN 'X' THEN 'Extended stored procedure'
					ELSE o.xtype
				END AS ObjectType,
				c.text
FROM sysobjects o
	 JOIN syscomments c ON o.id = c.id
WHERE o.type in ('P', 'FN', 'TF', 'TR', 'V', 'U')
      AND (lower(c.text) LIKE '%rem%' 
	       OR lower(c.text) LIKE '%isactive%')	 
ORDER BY ObjectName;


--kurd--
SELECT o.object_id, o.name, o.type, o.type_desc, c.text	
FROM sys.objects o JOIN
	 syscomments c ON o.object_id = c.id
WHERE o.type in ('P', 'FN', 'TF', 'TR', 'V', 'U')
      AND (lower(c.text) LIKE '%rem%' 
	       OR lower(c.text) LIKE '%isactive%')	 
ORDER BY o.name;


--clmn--
SELECT o.name ObjectsName, 
       c.name ColumnName,
	   o.*,
	   c.*
FROM sys.columns c 
     JOIN sys.objects o 
	   ON o.object_id = c.object_id 
WHERE o.type = 'U' 
      AND (lower(c.name) LIKE '%rem%' 
	       OR lower(c.name) LIKE '%isactive%')	   
ORDER BY o.name, c.name