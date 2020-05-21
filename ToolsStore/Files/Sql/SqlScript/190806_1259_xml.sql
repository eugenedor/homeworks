CREATE TABLE #tmp 
(
    Id  INT PRIMARY KEY,
    Txt XML
)

INSERT INTO #tmp ( Id, Txt )
SELECT 1, 
    (CAST('<root><node>1</node><node>2</node><node>3</node></root>' AS XML));

INSERT INTO #tmp ( Id, Txt )
SELECT 2, 
    (CAST('<root><node>100</node><node>101</node></root>' AS XML));

SELECT t.Id,
	   t.Txt,
	   t.Txt.query('(//root)') AS xml_root,
	   t.Txt.query('(//node)') AS xml_node,
	   t.Txt.value('(//node)[1]', 'varchar(1000)') AS xml_node1,
	   t.Txt.value('(//node)[2]', 'varchar(1000)') AS xml_node2,
	   t.Txt.value('(//node)[3]', 'varchar(1000)') AS xml_node3,
	   t.Txt.value('(//node)[4]', 'varchar(1000)') AS xml_node4
FROM #tmp t

SELECT Id, 
       Txt,
       p.value('.', 'varchar(1000)') AS TxtValue, 
	   p.query('.') AS TxtQuery,
	   p.query('.').value('.', 'varchar(1000)') AS TxtQueryValue
FROM #tmp
    CROSS APPLY Txt.nodes('//node') t(p);


IF OBJECT_Id('tempdb..#tmp') IS NOT NULL
BEGIN
    DROP TABLE #tmp;
END