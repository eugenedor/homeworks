DECLARE @tbl TABLE (id int identity(1,1), val VARCHAR(10))
INSERT INTO @tbl (val) VALUES (null),
                              (''),
							  ('False'),
							  ('0'),
							  ('off'),
							  ('True'),
							  ('1'),
							  ('on'),
							  ('test');

--1--
SELECT t.id,
       t.val,        	 
	   ISNULL(NULLIF(NULLIF(NULLIF(LOWER(LTRIM(RTRIM(t.val))), ''), 'false'), 'off'), '0') AS isFalse,
	   CASE WHEN LOWER(LTRIM(RTRIM(t.val))) IN ('true', 'on', '1') THEN '1' ELSE t.val END AS isTrue,
	   
	   CASE WHEN ISNULL(NULLIF(NULLIF(NULLIF(LOWER(LTRIM(RTRIM(t.val))), ''), 'false'), 'off'), '0') = '0' THEN 0
	        WHEN CASE WHEN LOWER(LTRIM(RTRIM(t.val))) IN ('true', 'on', '1') THEN '1' ELSE t.val END = '1' then 1
			ELSE -1
	   END AS boolVal
FROM @tbl t
ORDER BY t.id;


--2--
SELECT t.id,
       t.val,        	 
	   CASE WHEN LOWER(LTRIM(RTRIM(t.val))) IN ('false', 'off', '0', '') THEN '0' ELSE t.val END AS isFalse,
	   CASE WHEN LOWER(LTRIM(RTRIM(t.val))) IN ('true', 'on', '1') THEN '1' ELSE t.val END AS isTrue,
	   
	   CASE WHEN CASE WHEN LOWER(LTRIM(RTRIM(t.val))) IN ('false', 'off', '0', '') THEN '0' ELSE t.val END = '0' THEN 0
	        WHEN CASE WHEN LOWER(LTRIM(RTRIM(t.val))) IN ('true', 'on', '1') THEN '1' ELSE t.val END = '1' then 1
			ELSE -1
	   END AS boolVal
FROM @tbl t
ORDER BY t.id;