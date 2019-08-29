DECLARE @tData TABLE (id BIGINT IDENTITY(157, 1), nam NVARCHAR(100), dat DATETIME); --таблица с данными

--SELECT DATEDIFF(dd, 0, GETDATE()) AS num,
--       DATEADD(dd, DATEDIFF(dd, 0, GETDATE()), 0) AS date1,
--       CONVERT(NVARCHAR(10), GETDATE(), 102) AS string,
--       CAST(CONVERT(NVARCHAR(10), GETDATE(), 102) AS DATETIME) AS date2

DECLARE @curDate DATETIME;
SET @curDate = CAST(CONVERT(NVARCHAR(10), GETDATE(), 102) AS DATETIME) --DATEADD(dd, DATEDIFF(dd, 0, GETDATE()), 0)
--SELECT @curDate AS cur_date

DECLARE @i INT = 0;
WHILE (@i < 899)
BEGIN
  INSERT INTO @tData (nam, dat) 
  VALUES ('txt_' + CAST(@i+1 AS NVARCHAR(5)), DATEADD(dd, -@i, @curdate));
  SET @i = @i +1;
END
--SELECT * FROM @tData;

DECLARE @t TABLE (id BIGINT, rowNumber INT);  --таблица с номерами строк
DECLARE @totalItems   INT, --количество	
		@itemsPerPage INT, --количество на странице		
        @currentPage  INT, --текущая страница
		@pagesCount   INT, --количество страниц
		@pagesCount1  INT, --количество страниц
		@pagesCount2  INT; --количество страниц

INSERT @t (id, rowNumber)
SELECT d.id, ROW_NUMBER() OVER (ORDER BY d.dat DESC) AS rowNumber
FROM @tData d;

SET @totalItems = @@ROWCOUNT;
SET @itemsPerPage = 100;
SET @currentPage = 2;
SELECT @pagesCount = CEILING(CAST(@totalItems AS DECIMAL) / @itemsPerPage);
--1--
SET @pagesCount1 = @totalItems / @itemsPerPage;
IF (@pagesCount1 * @itemsPerPage < @totalItems) SET @pagesCount1 = @pagesCount1 + 1;
--2--
SELECT @pagesCount2 = @totalItems / @itemsPerPage + CASE WHEN (@totalItems % @itemsPerPage) > 0 THEN 1 ELSE 0 END;

SELECT @totalItems AS totalCount,
       @itemsPerPage AS itemsPerPage,
	   @currentPage AS currentPage,
       @pagesCount AS pagesCount, @pagesCount1 AS pagesCount1, @pagesCount2 AS pagesCount2


--FIN--
SELECT d.id, d.nam, d.dat
FROM @tData d
     JOIN @t t
	   ON d.id = t.id
WHERE t.rowNumber BETWEEN (@currentPage - 1) * @itemsPerPage + 1 and @currentPage * @itemsPerPage
ORDER BY d.dat DESC; 