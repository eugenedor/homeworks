USE ToolsStore
GO 

DECLARE @name NVARCHAR(128), 
        @string NVARCHAR(MAX);

DECLARE @Table TABLE 
(
	id         BIGINT IDENTITY(1,1), 
	nameEntity NVARCHAR(250)
)

--@Table--
INSERT INTO @Table (nameEntity) VALUES ('CT_CATEGORY'), 
                                       ('CT_VAT'), 
									   ('CT_BRAND'), 
									   ('SK_MODEL');

SELECT t.id, t.nameEntity 
FROM @Table AS t;


--SELECT--
DECLARE _cursor CURSOR LOCAL FOR
	SELECT t.nameEntity
	FROM @Table AS t

OPEN _cursor
	FETCH NEXT FROM _cursor INTO @name
	WHILE @@fetch_status  = 0
	BEGIN
		SET @string = 'SELECT * FROM ToolsStore.dbo.[' + @name +'] ORDER BY DateLoad ASC;'
		EXECUTE sp_executesql @string
		PRINT @string
		fetch next from _cursor into @name
	END
CLOSE _cursor
DEALLOCATE _cursor
