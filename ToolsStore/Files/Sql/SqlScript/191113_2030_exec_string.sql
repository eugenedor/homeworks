DECLARE @table Table (ID INT IDENTITY(1,1), Condition VARCHAR(250), RiskGroup INT);

INSERT INTO @table (Condition, RiskGroup)
VALUES ('val < beg',                 0), 
       ('beg <= val and val <= fin', 1), 
	   ('val > fin',                 2);

SELECT t.ID, t.Condition, t.RiskGroup
FROM @table t;


DECLARE @val DECIMAL(18,9),
		@beg DECIMAL(18,9),
		@fin DECIMAL(18,9);


SELECT @beg = 2, @fin = 4, @val = 2.3;
SELECT @val AS val, @beg AS beg, @fin AS fin;
	   
SELECT t.ID, 
       t.Condition, --REPLACE(REPLACE(REPLACE(REPLACE(t.Condition, 'значение', 'val'), 'начало', 'beg'), 'конец', 'fin'), ' и ', ' AND ') Formula, 
	   t.RiskGroup
FROM @table t;


DECLARE @query NVARCHAR(MAX);
WITH tcnt AS (SELECT COUNT(t0.id) countRows
			  FROM @table t0)
SELECT @query = ISNULL(@query, 'SELECT CASE ') + 
                'WHEN ' + t.Condition + ' ' +
				'THEN ' + CAST(t.RiskGroup AS NVARCHAR(20)) + ' ' +
				CASE 
				  WHEN ROW_NUMBER() OVER (ORDER BY t.id ASC) = tcnt.countRows THEN 'END FROM (SELECT ' 
				  + CAST(@val AS NVARCHAR(50)) + ' as val, ' 
				  + CAST(@beg AS NVARCHAR(50)) + ' as beg, ' 
				  + CAST(@fin AS NVARCHAR(50)) + ' as fin) t' 
				  ELSE '' 
				END
FROM @table t 
     CROSS JOIN tcnt;
PRINT @query;

DECLARE @t TABLE (RiskGroup int)
INSERT @t
EXECUTE sp_executesql @query

SELECT t.RiskGroup
FROM @t t;