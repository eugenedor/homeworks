USE ToolsStore
GO

CREATE FUNCTION dbo.FN_GET_PERIODS_MONTH
(
    @DateBegin DATETIME,
    @DateEnd   DATETIME
)
RETURNS @PeriodsMonth TABLE 
(
	Year      INT, 
	Month     INT, 
	DateBegin DATETIME, 
	DateEnd   DATETIME,
	Quart     INT
)
AS
BEGIN
	WITH Periods AS 
	(SELECT ROW_NUMBER() OVER (ORDER BY ty.Y, tm.M) AS Id,
		    ty.Y, tm.M, 
		    DATEADD(mm, tm.M -1, CONVERT(DATETIME, CAST(ty.Y AS NVARCHAR(4)) + '0101', 112)) AS DateBegin
	 FROM (SELECT n1.Value AS Y
	       FROM dbo.FN_GET_NUMBERS(YEAR(@DateBegin), YEAR(@DateEnd)) n1) ty
		   CROSS JOIN 
		  (SELECT n2.Value AS M
		   FROM dbo.FN_GET_NUMBERS(1, 12) n2) tm)

    INSERT INTO @PeriodsMonth (Year, Month, DateBegin, DateEnd, Quart)  
	SELECT tp.Y AS Year, 
	       tp.M AS Month, 
		   tp.DateBegin, 
		   DATEADD(dd, -1, DATEADD(mm, 1, tp.DateBegin)) AS DateEnd,
		   DATEPART(qq, tp.DateBegin) AS Quart
	FROM Periods tp
	WHERE tp.Id >= (SELECT DISTINCT tp1.Id
					FROM Periods tp1
					WHERE @DateBegin BETWEEN tp1.DateBegin AND DATEADD(dd, -1, DATEADD(mm, 1, tp1.DateBegin)))
		  AND
		  tp.Id <= (SELECT DISTINCT tp2.Id
					FROM Periods tp2
					WHERE @DateEnd BETWEEN tp2.DateBegin AND DATEADD(dd, -1, DATEADD(mm, 1, tp2.DateBegin)));

	RETURN;
END
