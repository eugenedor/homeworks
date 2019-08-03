USE ToolsStore
GO

DECLARE @tDescr TABLE 
(
	Id INT IDENTITY(1,1), 
	Type CHAR(2), 
	Name VARCHAR(50)
);

INSERT INTO @tDescr (Type, Name) VALUES
	('C',  'CHECK constraint'),
	('D',  'Default or DEFAULT constraint'),
	('F',  'FOREIGN KEY constraint'),
	('FN', 'Scalar function'),
	('IF', 'In-lined table-function'),
	('K',  'PRIMARY KEY or UNIQUE constraint'),
	('L',  'Log'),
	('P',  'Stored procedure'),
	('R',  'Rule'),
	('RF', 'Replication filter stored procedure'),
	('S',  'System table'),
	('TF', 'Table function'),
	('TR', 'Trigger'),
	('U',  'User table'),
	('V',  'View'),
	('X',  'Extended stored procedure');

--syscomments--
SELECT DISTINCT o.object_id ObjectId,
                o.name ObjectName,
                o.type ObjectType,
				(SELECT DISTINCT t.Name 
				 FROM @tDescr t 
				 WHERE t.Type COLLATE Latin1_General_CI_AI = o.Type) AS ObjectTypeDescr,
				c.text Txt
FROM sys.objects o
     JOIN sys.syscomments c
	   ON o.object_id = c.id
WHERE o.type in ('P', 'FN', 'TF', 'TR', 'V', 'U')
      AND LOWER(c.text) LIKE '%@position%';