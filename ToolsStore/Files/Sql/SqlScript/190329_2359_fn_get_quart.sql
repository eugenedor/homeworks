CREATE FUNCTION dbo.FN_GET_QUART
(
    @Date  DATETIME,
    @Quart SMALLINT = 0
)
RETURNS @Quarter TABLE 
(
	Quart SMALLINT, 
	DateBegin DATETIME, 
	DateEnd DATETIME
)
AS
BEGIN    
	DECLARE @DateBegin DATETIME;
	SET @DateBegin = CONVERT(DATETIME, CAST(YEAR(@Date) AS NVARCHAR(4)) + '0101', 112);

	DECLARE @Tbl TABLE (Quart SMALLINT, DateBegin DATETIME);

	WITH t AS (SELECT n FROM (VALUES (0),(1),(2),(3),(4),(5)) v(n))
	INSERT INTO @Tbl (Quart, DateBegin)
	SELECT t.n, DATEADD(qq, t.n - 1, @DateBegin) AS DateBegin
	FROM t;
	
	INSERT INTO @Quarter (Quart, DateBegin, DateEnd)  
	SELECT t.Quart, t.DateBegin, DATEADD(dd, -1, DATEADD(qq, 1, t.DateBegin)) AS DateEnd
	FROM @Tbl t
		 JOIN (SELECT t.Quart
			   FROM @Tbl t
			   WHERE @Date BETWEEN DateBegin AND DATEADD(dd, -1, DATEADD(qq, 1, t.DateBegin))) tcur
	       ON t.Quart BETWEEN tcur.Quart-1 AND tcur.Quart+1
	WHERE CASE @Quart 
			WHEN -1 THEN tcur.Quart-1
			WHEN 0 THEN tcur.Quart
			WHEN 1 THEN tcur.Quart+1
		  END = t.Quart;

	RETURN;
END
GO