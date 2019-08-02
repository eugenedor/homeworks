CREATE TABLE #t 
(
	id       BIGINT IDENTITY(101,2), 
	name     NVARCHAR(250),
	surname  NVARCHAR(250),
	sex      BIT,
	birthday DATETIME
);

INSERT INTO #t VALUES 
('Андрей', 'Андреев', 1, CONVERT(DATETIME, '1991.01.01', 102)), 
('Борис', 'Борисов', 1, CONVERT(DATETIME, '1992.02.02', 102)), 
('Виктория', 'Викторова', 0, CONVERT(DATETIME, '1993.03.03', 102)), 
('Глеб', 'Глебов', 1, CONVERT(DATETIME, '1994.04.04', 102)), 
('Диана', 'Дианова', 0, CONVERT(DATETIME, '1995.05.05', 102)), 
('Евгений', 'Евгеньев', 1, CONVERT(DATETIME, '1996.06.06', 102)), 
('Жанна', 'Жаннова', 0, CONVERT(DATETIME, '1997.07.07', 102)), 
('Захар', 'Захаров', 1, CONVERT(DATETIME, '1998.08.08', 102)), 
('Инна', 'Иннова', 0, CONVERT(DATETIME, '1999.09.09', 102)), 
('Константин', 'Костин', 1, CONVERT(DATETIME, '2000.10.10', 102));

--before--
SELECT t.id, t.name, t.surname, t.sex, t.birthday 
FROM #t t 
ORDER BY t.id;

--name--
UPDATE t1
SET t1.name = t2.name
FROM (SELECT t01.id,              
             t01.name, 
			 t01.sex,
			 ROW_NUMBER() OVER (PARTITION BY t01.sex ORDER BY NEWID()) rn
      FROM #t t01) t1
     JOIN 
     (SELECT t02.id, 
	         t02.name, 
			 t02.sex,
			 ROW_NUMBER() OVER (PARTITION BY t02.sex ORDER BY NEWID()) rn
      FROM #t t02) t2 
	    ON t1.rn = t2.rn
		   AND t1.sex = t2.sex;

--surname--
UPDATE t1
SET t1.surname = t2.surname
FROM (SELECT t01.id,              
             t01.surname, 
			 t01.sex,
			 ROW_NUMBER() OVER (PARTITION BY t01.sex ORDER BY NEWID()) rn
      FROM #t t01) t1
     JOIN 
     (SELECT t02.id, 
	         t02.surname, 
			 t02.sex,
			 ROW_NUMBER() OVER (PARTITION BY t02.sex ORDER BY NEWID()) rn
      FROM #t t02) t2 
	    ON t1.rn = t2.rn
		   AND t1.sex = t2.sex;

--birthday--
UPDATE t1
SET t1.birthday = t2.birthday
FROM (SELECT t01.id,              
             t01.birthday, 
			 ROW_NUMBER() OVER (ORDER BY NEWID()) rn
      FROM #t t01) t1
     JOIN 
     (SELECT t02.id, 
	         t02.birthday, 
			 ROW_NUMBER() OVER (ORDER BY NEWID()) rn
      FROM #t t02) t2 
	    ON t1.rn = t2.rn;

--after--
SELECT t.id, t.name, t.surname, t.sex, t.birthday 
FROM #t t 
ORDER BY t.id;

DROP TABLE #t