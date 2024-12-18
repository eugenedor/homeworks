USE ToolsStore;
GO

ALTER FUNCTION dbo.FN_SPLIT
(
    @String    NVARCHAR(MAX),
    @Delimiter NVARCHAR(100),
	@WithDouble BIT
)
RETURNS @tValues TABLE
(
    Id    INT IDENTITY(1,1) NOT NULL PRIMARY KEY,
	Value NVARCHAR(MAX) 
)
AS
BEGIN
    DECLARE @Pos INT;

    WHILE LEN(@String) > 0
    BEGIN 
        SELECT @Pos = CASE CHARINDEX(@Delimiter, @String) 
						  WHEN 0 THEN LEN(@String) 
						  ELSE CHARINDEX(@Delimiter, @String) - 1
					  END;
        
        IF (@WithDouble = 1 OR
		    NOT EXISTS(SELECT Value 
		               FROM @tValues 
			     	   WHERE Value = (SELECT CAST(SUBSTRING(@String, 1, @Pos) AS NVARCHAR(100))))
			)
			INSERT INTO @tValues (Value)  
			SELECT LTRIM(RTRIM(CAST(SUBSTRING(@String, 1, @Pos) AS NVARCHAR(MAX))))

        SELECT @String = CASE 
		                     WHEN @Pos != LEN(@String) THEN RIGHT(@String, LEN(@String) - @Pos - LEN(@Delimiter))
                             ELSE ''
					     END
    END 
    
	RETURN;
END