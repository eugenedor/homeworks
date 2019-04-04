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
	DECLARE @DateQ DATETIME;
	SET @DateQ = CONVERT(DATETIME, CAST(YEAR(@Date) AS NVARCHAR(4)) + '0101', 112);

	WITH t AS (SELECT n FROM (VALUES (0),(1),(2),(3),(4),(5)) v(n)),
	     tbl AS (SELECT t.n AS Quart, DATEADD(qq, t.n - 1, @DateQ) AS DateBegin
	             FROM t)
	
	INSERT INTO @Quarter (Quart, DateBegin, DateEnd)  
	SELECT tq.Quart, 
	       tq.DateBegin, 
		   DATEADD(dd, -1, DATEADD(qq, 1, tq.DateBegin)) AS DateEnd
	FROM tbl tq
		 JOIN (SELECT Quart
			   FROM tbl
			   WHERE @Date BETWEEN DateBegin AND DATEADD(dd, -1, DATEADD(qq, 1, DateBegin))) tcur
	       ON tq.Quart BETWEEN tcur.Quart-1 AND tcur.Quart+1
	WHERE CASE @Quart 
			WHEN -1 THEN tcur.Quart-1
			WHEN 0 THEN tcur.Quart
			WHEN 1 THEN tcur.Quart+1
		  END = tq.Quart;

	RETURN;
END
GO