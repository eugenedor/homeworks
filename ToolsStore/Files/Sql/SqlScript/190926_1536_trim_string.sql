USE ToolsStore
GO

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

IF EXISTS (SELECT * FROM sys.objects WHERE OBJECT_ID = OBJECT_ID('FN_TRIM_STRING') AND type = N'FN')
BEGIN
	DROP FUNCTION dbo.FN_TRIM_STRING
END
GO

CREATE FUNCTION dbo.FN_TRIM_STRING
(
	@String NVARCHAR(4000)	
)
RETURNS NVARCHAR(4000)
AS
BEGIN
	DECLARE @Value NVARCHAR(4000),
			@Delimiter NVARCHAR(5),
			@Pos INT;

	SELECT @String = LTRIM(RTRIM(@String)),
	       @Delimiter = ' ',
		   @Value = '';

	IF(NULLIF(@String, '') IS NULL)
	BEGIN 
		SET @Value = @String;
	END 
	ELSE
	BEGIN
		WHILE LEN(@String) > 0
		BEGIN 
			SELECT @Pos = CASE CHARINDEX(@Delimiter, @String) 
						      WHEN 0 THEN LEN(@String) 
						      ELSE CHARINDEX(@Delimiter, @String) 
						  END;
	    
			IF (@Pos != LEN(@String))
			BEGIN 
    			WHILE (SUBSTRING(@String, @Pos, 1) = SUBSTRING(@String, @Pos+1, 1))
				BEGIN
					SET @String = SUBSTRING(@String, 1, @Pos) + SUBSTRING(@String, @Pos+2, LEN(@String));
				END
			END

			SET @Value = ISNULL(@Value, '') + SUBSTRING(@String, 1, @Pos);

			SELECT @String = CASE 
			                     WHEN @pos != LEN(@String) THEN RIGHT(@String, LEN(@String) - @Pos) 
			                     ELSE ''
							 END;
		END
	END

	RETURN @Value;
END
