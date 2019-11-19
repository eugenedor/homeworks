DECLARE @t TABLE (txt VARCHAR(450), val DECIMAL(18,9));

INSERT INTO @t (txt, val) 
VALUES ('Text1', 1), ('Text2', 2);

--0--
SELECT t.txt, t.val
FROM @t t;

--1_pivot--
SELECT [Text1] AS t01, [Text2] AS t02
FROM
(SELECT t.txt, t.val 
 FROM  @t t) AS srcTbl
PIVOT  
(  
SUM(val)
FOR txt IN ([Text1], [Text2])  
) AS pvtTbl;

--2_case--
SELECT SUM(CASE WHEN t.txt = 'Text1' THEN t.val END) t11,
	   SUM(CASE WHEN t.txt = 'Text2' THEN t.val END) t12
FROM @t t;