CREATE TABLE #t (id BIGINT IDENTITY(101,2), name NVARCHAR(250))

INSERT INTO #t  VALUES ('Андрей'), 
                       ('Борис'), 
					   ('Виктор'), 
					   ('Глеб'), 
					   ('Дмитрий'), 
					   ('Евгений'), 
					   ('Жерар'), 
					   ('Захар'), 
					   ('Илья'), 
					   ('Константин');

--before--
SELECT t.id, t.name FROM #t t ORDER BY t.id;

UPDATE t1
SET t1.name = t2.name
FROM (SELECT t01.id, 
             t01.name, 
			 ROW_NUMBER() OVER (ORDER BY NEWID()) rn
      FROM #t t01) t1
     JOIN 
     (SELECT t02.id, 
	         t02.name, 
			 ROW_NUMBER() OVER (ORDER BY NEWID()) rn
      FROM #t t02) t2 
	    ON t1.rn = t2.rn;

--after--
SELECT t.id, t.name FROM #t t ORDER BY t.id;

DROP TABLE #t