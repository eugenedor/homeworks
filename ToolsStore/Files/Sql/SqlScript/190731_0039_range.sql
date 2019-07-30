CREATE TABLE #t (x NVARCHAR(10), y NVARCHAR(10))

INSERT INTO #t(x, y) VALUES('A','a')
INSERT INTO #t(x, y) VALUES('A','b')
INSERT INTO #t(x, y) VALUES('A','c')
INSERT INTO #t(x, y) VALUES('B','d')
INSERT INTO #t(x, y) VALUES('B','e')
INSERT INTO #t(x, y) VALUES('B','f')
INSERT INTO #t(x, y) VALUES('C','g')
INSERT INTO #t(x, y) VALUES('C','h')

SELECT t.x, t.y
FROM #t t

SELECT t.x, t.y,
	   '-' AS xxx,
	   ROW_NUMBER() OVER (ORDER BY t.x ASC) AS rn1,
	   ROW_NUMBER() OVER (PARTITION BY t.x ORDER BY t.y ASC) AS rn2,
	   '-' AS xxx,
	   RANK() OVER (ORDER BY t.x) AS 'Rank',
	   DENSE_RANK() OVER (ORDER BY t.x) AS 'Dense Rank',
	   '-' AS xxx,
	   NTILE(4) OVER (ORDER BY t.x) AS 'Quartile'
FROM #t t
ORDER BY t.y

DROP TABLE #t