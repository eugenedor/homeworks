USE ToolsStore
GO

--syscomments--
SELECT DISTINCT o.object_id,
                o.name AS ObjectName,
                o.type,
				CASE o.type
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
					ELSE o.type
				END AS ObjectType,
				c.text
FROM sys.objects o
     JOIN sys.syscomments c
	   ON o.object_id = c.id
WHERE o.type in ('P', 'FN', 'TF', 'TR', 'V', 'U')
      AND lower(c.text) LIKE '%@position%';