CREATE FUNCTION dbo.FN_GET_QUART
(
    @date DATETIME,
    @qrt  SMALLINT = 0
)
RETURNS @table TABLE (quart SMALLINT, dbeg DATETIME, dend DATETIME)
AS
BEGIN    
	DECLARE @dbeg DATETIME;
	SET @dbeg = CONVERT(DATETIME, CAST(YEAR(@date) AS NVARCHAR(4)) + '0101', 112);

	DECLARE @t TABLE(quart SMALLINT, dbeg DATETIME);
	WITH t AS (SELECT n FROM (VALUES (0),(1),(2),(3),(4),(5)) v(n))
	INSERT INTO @t (quart, dbeg)
	SELECT t.n, DATEADD(qq, t.n - 1, @dbeg) AS dbeg
	FROM t;
	
	INSERT INTO @table (quart, dbeg, dend)  
	SELECT t.quart, t.dbeg, DATEADD(dd, -1, DATEADD(qq, 1, t.dbeg)) AS dend
	FROM @t t
		 JOIN (SELECT t.quart
			   FROM @t t
			   WHERE @date BETWEEN dbeg AND DATEADD(dd, -1, DATEADD(qq, 1, t.dbeg))) tcur
	       ON t.quart BETWEEN tcur.quart-1 AND tcur.quart+1
	WHERE CASE @qrt 
			WHEN -1 THEN tcur.quart-1
			WHEN 0 THEN tcur.quart
			WHEN 1 THEN tcur.quart+1
		  END = t.quart;

	RETURN;
END
GO