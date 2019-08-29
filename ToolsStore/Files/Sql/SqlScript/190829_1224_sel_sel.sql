DECLARE @t1 TABLE (id1 INT);
DECLARE @t2 TABLE (id2 INT, name VARCHAR(100));

INSERT INTO @t1 (id1) VALUES (1), (2), (2), (3), (4), (4), (5), (6);
INSERT INTO @t2 (id2, name) VALUES (1, 'a'), (2, 'b'), (3, 'c'), (5, 'd');

SELECT t1.id1 FROM @t1 t1;
SELECT t2.id2, t2.name FROM @t2 t2;

--1--
SELECT t1.id1, 
       (SELECT DISTINCT t2.name 
        FROM @t2 t2 
	    WHERE t2.id2 = t1.id1) name
FROM @t1 t1
WHERE t1.id1 IN (SELECT id2 
                 FROM @t2);

--2--
SELECT t1.id1, 
       (SELECT DISTINCT t2.name 
        FROM @t2 t2 
	    WHERE t2.id2 = t1.id1) name
FROM @t1 t1
WHERE EXISTS (SELECT 1 
              FROM @t2 
			  WHERE id2 = t1.id1);

--3--
SELECT t1.id1, t2.name
FROM @t1 t1
     join @t2 t2
	   ON t1.id1 = t2.id2;