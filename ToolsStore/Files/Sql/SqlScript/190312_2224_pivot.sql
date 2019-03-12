DECLARE @tbl TABLE (Code INT, 
                    Price DECIMAL(17,2));

DECLARE @pvt TABLE (Code NVARCHAR(250), 
                    MaxPrice0 DECIMAL(17,2), 
					MaxPrice1 DECIMAL(17,2), 
					MaxPrice2 DECIMAL(17,2), 
					MaxPrice3 DECIMAL(17,2), 
					MaxPrice4 DECIMAL(17,2));


--(1)-PIVOT--------------------------------
--
--INSERT_TBL--
--
INSERT INTO @tbl (Code, Price) 
VALUES  (0, 13.3), 
		(0, 2.5), 
		(1, 1), 
		(1, 2.7), 
		(2, 3.3), 
		(2, 2.2), 
		(2, 4.4), 
		(4, 11.9), 
		(4, 0.5);


--
--GROUP BY TBL--                            
--
SELECT tbl.Code, MAX(tbl.Price) AS MaxPrice
FROM @tbl tbl
GROUP BY tbl.Code;


--
--PIVOT--
--
SELECT 'MaxPrice' AS PriceSortedByCode, 
       [0] AS MaxPrice0, 
       [1] AS MaxPrice1, 
       [2] AS MaxPrice2, 
       [3] AS MaxPrice3, 
       [4] AS MaxPrice4
FROM
(SELECT tbl.Code, tbl.Price   
 FROM @tbl tbl) AS SourceTable
PIVOT  
(  
MAX(Price)  
FOR Code IN ([0], [1], [2], [3], [4])  
) AS PivotTable;  


--(2)-UNPIVOT------------------------------
--
--INSERT_PVT--
--
INSERT INTO @pvt (Code, MaxPrice0, MaxPrice1, MaxPrice2, MaxPrice3, MaxPrice4)
SELECT 'MaxPrice' AS PriceSortedByCode, 
       [0] AS MaxPrice0, 
       [1] AS MaxPrice1, 
       [2] AS MaxPrice2, 
       [3] AS MaxPrice3, 
       [4] AS MaxPrice4
FROM
(SELECT tbl.Code, tbl.Price   
 FROM @tbl tbl) AS SourceTable
PIVOT  
(  
MAX(Price)  
FOR Code IN ([0], [1], [2], [3], [4])  
) AS PivotTable;


--
--SELECT PVT
--
select pvt.Code, pvt.MaxPrice0, pvt.MaxPrice1, pvt.MaxPrice2, pvt.MaxPrice3, pvt.MaxPrice4
from @pvt pvt


--
--UNPIVOT-- 
--
SELECT case ColumnNames when 'MaxPrice0' then 0
                        when 'MaxPrice1' then 1
                        when 'MaxPrice2' then 2
                        when 'MaxPrice3' then 3
                        when 'MaxPrice4' then 4
     end Code,
     MaxPrice,
     ColumnNames
FROM   
   (SELECT pvt.Code, pvt.MaxPrice0, pvt.MaxPrice1, pvt.MaxPrice2, pvt.MaxPrice3, pvt.MaxPrice4  
    FROM @pvt pvt) p  
UNPIVOT  
   (MaxPrice FOR ColumnNames IN (MaxPrice0, MaxPrice1, MaxPrice2, MaxPrice3, MaxPrice4)  
)AS unpvt;  
GO