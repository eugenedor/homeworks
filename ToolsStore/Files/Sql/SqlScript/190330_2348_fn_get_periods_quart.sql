USE ToolsStore
GO

CREATE FUNCTION dbo.FN_GET_PERIODS_QUART
(
    @DateBegin DATETIME,
    @DateEnd   DATETIME
)
RETURNS @PeriodsQuart TABLE 
(
	Year      INT, 
	Quart     INT, 
	DateBegin DATETIME, 
	DateEnd   DATETIME
)
AS
BEGIN
	WITH Periods AS 
	(SELECT ROW_NUMBER() OVER (ORDER BY ty.Y, tq.Q) AS Id,
		    ty.Y, tq.Q , 
		    DATEADD(mm, (tq.Q -1) * 3, CONVERT(DATETIME, CAST(ty.Y AS NVARCHAR(4)) + '0101', 112)) AS DateBegin
	 FROM (SELECT n1.Value AS Y
	       FROM dbo.FN_GET_NUMBERS(YEAR(@DateBegin), YEAR(@DateEnd)) n1) ty
		   CROSS JOIN 
		  (SELECT n2.Value AS Q
		   FROM dbo.FN_GET_NUMBERS(1, 4) n2) tq)

    INSERT INTO @PeriodsQuart (Year, Quart, DateBegin, DateEnd)  
	SELECT tp.Y AS Year, 
	       tp.Q AS Quart, 
		   tp.DateBegin, 
		   DATEADD(dd, -1, DATEADD(qq, 1, tp.DateBegin)) AS DateEnd
	FROM Periods tp
	WHERE tp.Id >= (SELECT DISTINCT tp1.Id
					FROM Periods tp1
					WHERE @DateBegin BETWEEN tp1.DateBegin AND DATEADD(dd, -1, DATEADD(qq, 1, tp1.DateBegin)))
		  AND
		  tp.Id <= (SELECT DISTINCT tp2.Id
					FROM Periods tp2
					WHERE @DateEnd BETWEEN tp2.DateBegin AND DATEADD(dd, -1, DATEADD(qq, 1, tp2.DateBegin)))
	ORDER BY tp.Y, tp.Q;

	RETURN;
END
