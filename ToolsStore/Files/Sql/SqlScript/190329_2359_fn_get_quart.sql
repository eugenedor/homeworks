DECLARE @date DATETIME,
        @dbeg DATETIME,
		@qrt  SMALLINT

DECLARE @t TABLE(quart SMALLINT, dbeg DATETIME);

SELECT @date = GETDATE(),       
       @dbeg = CONVERT(DATETIME, CAST(YEAR(@date) AS NVARCHAR(4)) + '0101', 112),
	   @qrt = 1;

WITH t AS (SELECT n FROM (VALUES (0),(1),(2),(3),(4),(5)) v(n))
INSERT INTO @t (quart,dbeg )
SELECT t.n, DATEADD(qq, t.n-1, @dbeg) AS dbeg
FROM t;

SELECT t.quart, t.dbeg, DATEADD(dd, -1, DATEADD(qq, 1, t.dbeg)) AS dend
FROM @t t
     JOIN (SELECT t.quart
		   FROM @t t
           WHERE @date between dbeg and dateadd(dd, -1, dateadd(qq, 1, t.dbeg))) tcur
on t.quart between tcur.quart-1 and tcur.quart+1
where case @qrt 
          when -1 then tcur.quart-1
		  when 0 then tcur.quart
		  when 1 then tcur.quart+1
	  end = t.quart