USE ToolsStore
GO

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

IF EXISTS (SELECT * FROM sys.objects WHERE OBJECT_ID = OBJECT_ID('FN_SPLIT2') AND type = N'TF')
BEGIN
	DROP FUNCTION dbo.FN_SPLIT2
END
GO

CREATE FUNCTION dbo.FN_SPLIT2
(    
    @String   NVARCHAR(MAX),
    @Delimiter NVARCHAR(100)
)
RETURNS @tValues TABLE 
(
    Id    INT IDENTITY(1,1),
    Value NVARCHAR(MAX)
) 
AS
BEGIN 
    WHILE (CHARINDEX(@Delimiter,@String) > 0)
    BEGIN
        INSERT INTO @tValues (Value)
        SELECT LTRIM(RTRIM(SUBSTRING(@String, 1, CHARINDEX(@Delimiter,@String) - 1))) Value

        SET @String = RIGHT(@String, LEN(@String) - (CHARINDEX(@Delimiter,@String) - 1) - LEN(@Delimiter))
    END
    
    INSERT INTO @tValues (Value)
    SELECT LTRIM(RTRIM(@String)) Value

    RETURN;
END
