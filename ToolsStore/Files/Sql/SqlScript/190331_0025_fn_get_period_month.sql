USE ToolsStore
GO

CREATE FUNCTION dbo.FN_GET_PERIOD_MONTH
(
    @dbeg DATETIME,
    @dend DATETIME
)
RETURNS @table TABLE (year INT, month INT, dbeg DATETIME, dend DATETIME)
AS
BEGIN    
	DECLARE @c        INT,
			@yeardiff INT;
	DECLARE @tyear  TABLE(y INT);
	DECLARE @tmonth TABLE(m INT);

	SELECT @yeardiff = DATEDIFF(YY, @dbeg, @dend) + 1;

	SET @c = 1;
	WHILE (@c <= @yeardiff)
	BEGIN
	  INSERT INTO @tyear (y)
	  SELECT YEAR(@dbeg) + @c - 1;
	  SET @c = @c + 1;
	END;

	INSERT INTO @tmonth (m) VALUES (1), (2), (3), (4), (5), (6), (7), (8), (9), (10), (11), (12);

	WITH tperiod AS 
	(SELECT ROW_NUMBER() OVER (ORDER BY ty.y, tm.m) AS id,
		   ty.y, tm.m , 
		   DATEADD(mm, tm.m -1, CONVERT(DATETIME, CAST(ty.y AS NVARCHAR(4)) + '0101', 112)) AS dbeg
	FROM @tyear ty
		 CROSS JOIN @tmonth tm)

    INSERT INTO @table (year, month, dbeg, dend)  
	SELECT tp.y AS year, tp.m AS month, tp.dbeg, DATEADD(dd, -1, DATEADD(mm, 1, tp.dbeg)) AS dend
	FROM tperiod tp
	WHERE tp.id >= (SELECT DISTINCT tp1.id
					FROM tperiod tp1
					WHERE @dbeg BETWEEN tp1.dbeg AND DATEADD(dd, -1, DATEADD(mm, 1, tp1.dbeg)))
		  AND
		  tp.id <= (SELECT DISTINCT tp2.id
					FROM tperiod tp2
					WHERE @dend BETWEEN tp2.dbeg AND DATEADD(dd, -1, DATEADD(mm, 1, tp2.dbeg)));

	RETURN;
END
