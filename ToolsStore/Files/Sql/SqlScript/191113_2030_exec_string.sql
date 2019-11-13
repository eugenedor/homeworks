DECLARE @table Table (ID INT IDENTITY(1,1), Condition VARCHAR(250), RiskGroup INT);

INSERT INTO @table (Condition, RiskGroup)
VALUES ('значение < начало',                        0), 
       ('начало <= значение и значение <= конец', 1), 
	   ('значение > конец',                        2);

SELECT t.ID, t.Condition, t.RiskGroup
FROM @table t;


DECLARE @val DECIMAL(18,9),
		@beg DECIMAL(18,9),
		@fin DECIMAL(18,9);


SELECT @beg = 2, 
	   @fin = 4, 
	   @val = 2.3;


SELECT @val    AS val,
	   @beg AS beg,
	   @fin AS fin;
	   

SELECT t.ID, 
       t.Condition, 
	   REPLACE(REPLACE(REPLACE(REPLACE(t.Condition, 'значение', 'val'), 'начало', 'beg'), 'конец', 'fin'), ' и ', ' AND ') Formula, 
	   t.RiskGroup
FROM @table t;


DECLARE @query VARCHAR(MAX);
SELECT @query = isnull(@query, 'SELECT CASE ') + 
                'WHEN ' + 
				REPLACE(REPLACE(REPLACE(REPLACE(t.Condition, 'значение', 'val'), 'начало', 'beg'), 'конец', 'fin'), ' и ', ' AND ') + ' ' +
				'THEN ' + CAST(t.RiskGroup AS VARCHAR(20)) + ' ' 
FROM @table t;
SELECT @query = @query + 'END FROM (SELECT ' + 
                CAST(@val AS VARCHAR(20)) + ' AS val, ' + 
				CAST(@beg AS VARCHAR(20)) + ' AS beg, ' + 
				CAST(@fin AS VARCHAR(20)) + ' AS fin) t'

PRINT @query;

DECLARE @t TABLE (result int)
INSERT @t
EXEC (@query)

SELECT result 
FROM @t;