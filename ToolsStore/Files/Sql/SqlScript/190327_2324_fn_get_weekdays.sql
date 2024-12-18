USE ToolsStore
GO

CREATE FUNCTION dbo.FN_GET_WEEKDAYS
(	
    @DateBegin DATETIME,  
    @DateEnd   DATETIME  
)
RETURNS INT 
AS
BEGIN 
    DECLARE @Range INT; 
    SET @Range = DATEDIFF(DAY, @DateBegin, @DateEnd)+1; 
    RETURN  
    ( 
        SELECT @Range / 7 * 5                                                  --whole part
		       + @Range % 7                                                    --modulo
			   - (SELECT COUNT(*)                                              --modulo (weekend)
			      FROM (SELECT d 
						FROM (VALUES (1),(2),(3),(4),(5),(6),(7)) v(d)) tWeek
                  WHERE d <= @Range % 7  
                        AND DATEPART(WEEKDAY, @DateEnd - d + 1) IN (1, 7))     --days: sunday, saturday
    )
END  