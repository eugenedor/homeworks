DECLARE @dbeg     DATETIME,
        @dend     DATETIME,
		@c        INT,
		@yeardiff INT;

DECLARE @tyear  TABLE (y INT);
DECLARE @tquart TABLE (q INT);

SET @dbeg = CONVERT(DATETIME, '20180409', 112);
SET @dend = CONVERT(DATETIME, '20190330', 112);

SELECT @dbeg as db, @dend as de
SELECT @yeardiff = DATEDIFF(YY, @dbeg, @dend) + 1

SET @c = 1;
WHILE (@c <= @yeardiff)
BEGIN
  INSERT INTO @tyear (y)
  SELECT YEAR(@dbeg) + @c - 1;
  SET @c = @c + 1;
END;

SELECT * FROM @tyear;

INSERT INTO @tquart (q) VALUES (1), (2), (3), (4);

SELECT * FROM @tquart;

SELECT ROW_NUMBER() OVER (ORDER BY ty.y, tq.q) AS id,
       ty.y, tq.q , 
	   DATEADD(mm, (tq.q -1) * 3, CONVERT(DATETIME, CAST(ty.y AS NVARCHAR(4)) + '0101', 112)) AS dbeg
FROM @tyear ty
     CROSS JOIN @tquart tq
ORDER BY ty.y, tq.q;

WITH tperiod AS 
(SELECT ROW_NUMBER() OVER (ORDER BY ty.y, tq.q) AS id,
       ty.y, tq.q , 
	   DATEADD(mm, (tq.q -1) * 3, CONVERT(DATETIME, CAST(ty.y AS NVARCHAR(4)) + '0101', 112)) AS dbeg
FROM @tyear ty
     CROSS JOIN @tquart tq)

SELECT tp.y AS year, tp.q AS quart, tp.dbeg, DATEADD(dd, -1, DATEADD(qq, 1, tp.dbeg)) AS dend
FROM tperiod tp
WHERE tp.id >= (SELECT DISTINCT tp1.id
			    FROM tperiod tp1
			    WHERE @dbeg BETWEEN tp1.dbeg AND DATEADD(dd, -1, DATEADD(qq, 1, tp1.dbeg)))
	  AND
	  tp.id <= (SELECT DISTINCT tp2.id
			    FROM tperiod tp2
			    WHERE @dend BETWEEN tp2.dbeg AND DATEADD(dd, -1, DATEADD(qq, 1, tp2.dbeg)))