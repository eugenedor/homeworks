USE ToolsStore
GO

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

IF EXISTS (SELECT * FROM sys.objects WHERE OBJECT_ID = OBJECT_ID('FN_TRANSLIT') AND type = N'FN')
BEGIN
	DROP FUNCTION dbo.FN_TRANSLIT
END
GO

CREATE FUNCTION dbo.FN_TRANSLIT 
(
	@String NVARCHAR(MAX)
)  
RETURNS NVARCHAR(MAX) 
AS 
BEGIN  
	DECLARE @tTrans TABLE(Rus CHAR PRIMARY KEY, Lat VarChar(2));
	DECLARE	@Value	VARCHAR(MAX);
 
	INSERT @tTrans (Rus, Lat)
	          SELECT '�', 'A'
	UNION ALL SELECT '�', 'B'
	UNION ALL SELECT '�', 'V'
	UNION ALL SELECT '�', 'G'
	UNION ALL SELECT '�', 'D'
	UNION ALL SELECT '�', 'E'
	UNION ALL SELECT '�', 'Yo'
	UNION ALL SELECT '�', 'Zh'
	UNION ALL SELECT '�', 'Z'
	UNION ALL SELECT '�', 'I'
	UNION ALL SELECT '�', 'Y'
	UNION ALL SELECT '�', 'K'
	UNION ALL SELECT '�', 'L'
	UNION ALL SELECT '�', 'M'
	UNION ALL SELECT '�', 'N'
	UNION ALL SELECT '�', 'O'
	UNION ALL SELECT '�', 'P'
	UNION ALL SELECT '�', 'R'
	UNION ALL SELECT '�', 'S'
	UNION ALL SELECT '�', 'T'
	UNION ALL SELECT '�', 'U'
	UNION ALL SELECT '�', 'F'
	UNION ALL SELECT '�', 'H'
	UNION ALL SELECT '�', 'C'
	UNION ALL SELECT '�', 'Ch'
	UNION ALL SELECT '�', 'Sh'
	UNION ALL SELECT '�', 'Sh'
	UNION ALL SELECT '�', ''
	UNION ALL SELECT '�', 'Y'
	UNION ALL SELECT '�', ''
	UNION ALL SELECT '�', 'E'
	UNION ALL SELECT '�', 'Yu'
	UNION ALL SELECT '�', 'Ya';
	
	SET	@Value	= @String;
	
	SELECT @Value = REPLACE(@Value, UPPER(Rus) COLLATE Cyrillic_General_CS_AS, Lat) 
	FROM @tTrans 
	WHERE @String LIKE '%' + Rus + '%';

	SELECT @Value = REPLACE(@Value, LOWER(Rus) COLLATE Cyrillic_General_CI_AS, LOWER(Lat)) 
	FROM @tTrans 
	WHERE @String LIKE '%' + Rus + '%';
	
	RETURN @Value;   
END  