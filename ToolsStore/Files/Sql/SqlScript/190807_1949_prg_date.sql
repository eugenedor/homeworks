DECLARE @date DATETIME;
DECLARE @prgName TABLE 
(
	Id INT IDENTITY(1,1), 
	Name VARCHAR(250)
);

SET @date = CONVERT(DATETIME, '2019.08.06', 102);
--SET @date = GETDATE();

INSERT INTO @prgName (Name) VALUES
('Программа yyyy.mm.dd'),
('Программа yyyy.mm.dd демо'),
('Программа yyyy.mm.dd релиз');

SELECT @date date1,
       CONVERT(VARCHAR(12), @date, 102) date2;

SELECT t.Id, t.Name, 
       PATINDEX('%yyyy.mm.dd%', t.Name) AS p_indx,
       CHARINDEX('yyyy.mm.dd', t.Name) AS c_indx,
	   SUBSTRING(t.Name, CHARINDEX('yyyy.mm.dd', t.Name), 10) AS sbstr,
	   REPLACE(t.Name, 'yyyy.mm.dd', CONVERT(VARCHAR(12), @date, 102)) AS rslt,
	   STUFF(t.Name, CHARINDEX('yyyy.mm.dd', t.Name), 10, CONVERT(VARCHAR(12), @date, 102)) AS result
FROM @prgName t;