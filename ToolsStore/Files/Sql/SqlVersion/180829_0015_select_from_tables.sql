USE ToolsStore
GO 

--SELECT * FROM sys.tables WHERE type_desc = 'USER_TABLE' AND name like '%life[_]%'
--SELECT * FROM sysobjects WHERE xtype = 'U' AND name like '%life[_]%'
--SELECT table_name FROM information_schema.tables WHERE table_name like '%life[_]%'


DECLARE @name NVARCHAR(128), 
        @string NVARCHAR(MAX)

DECLARE @Table TABLE (id BIGINT IDENTITY(1,1), nameEntity NVARCHAR(250));
DECLARE @TableRes TABLE (id BIGINT IDENTITY(1,1), nameEntity NVARCHAR(250), cntRecord int);

DECLARE _cur1 CURSOR LOCAL FOR
	SELECT table_name 
	FROM information_schema.tables 
	ORDER BY table_name
open _cur1
	fetch next from _cur1 INTO @name
	while @@fetch_status  = 0
	BEGIN
		SET @string = 'IF ((SELECT COUNT(*) FROM dbo.[' + @name +']) > 0) ' + 
		                'BEGIN SELECT ''' +@name + ''' END'
		INSERT INTO @Table (nameEntity)
		EXECUTE sp_executesql @string
		--PRINT @string
		fetch next from _cur1 into @name
	end
close _cur1
deallocate _cur1


DECLARE _cur2 CURSOR LOCAL FOR
	SELECT t.nameEntity
	FROM @Table AS t
	ORDER BY T.nameEntity
open _cur2
	fetch next from _cur2 INTO @name
	while @@fetch_status  = 0
	BEGIN	    
		SET @string = 'SELECT ''' + @name +''' as nameEntity, count(*) as cntRecord FROM dbo.[' + @name +']'
		INSERT INTO @TableRes (nameEntity, cntRecord)
		EXECUTE sp_executesql @string
		PRINT @string
		fetch next from _cur2 into @name
	end
close _cur2
deallocate _cur2

SELECT t.id, t.nameEntity, t.cntRecord 
FROM @TableRes AS t
