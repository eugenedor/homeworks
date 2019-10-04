-- Create an Employee table.  
CREATE TABLE #tMyEmployees 
(  
	EmployeeID INT NOT NULL,  
	FirstName  NVARCHAR(30)  NOT NULL,  
	LastName   NVARCHAR(40) NOT NULL,  
	Title      NVARCHAR(50) NOT NULL,   
	ManagerID  INT NULL,  
	CONSTRAINT PK_EmployeeID PRIMARY KEY CLUSTERED (EmployeeID ASC)   
);  
-- Populate the table with values.  
INSERT INTO #tMyEmployees VALUES   
 (1, N'Ken',     N'Sánchez',  N'Chief Executive Officer',      NULL),
 (2, N'Brian',   N'Welcker',  N'Vice President of Sales',      1),
 (3, N'Stephen', N'Jiang',    N'North American Sales Manager', 2),
 (4, N'Syed',    N'Abbas',    N'Pacific Sales Manager',        2),
 (5, N'David',   N'Bradley',  N'Marketing Manager',            2),
 (6, N'Michael', N'Blythe',   N'Sales Representative',         3),
 (7, N'Linda',   N'Mitchell', N'Sales Representative',         3),
 (8, N'Lynn',    N'Tsoflias', N'Sales Representative',         4),
 (9, N'Mary',    N'Gibson',   N'Marketing Specialist',         5);  

SELECT * 
FROM #tMyEmployees;

WITH DirectReports(ManagerID, EmployeeID, FirstName, LastName, Title, EmployeeLevel) AS   
(  
    SELECT ManagerID, EmployeeID, FirstName, LastName, Title, 0 AS EmployeeLevel  
    FROM dbo.#tMyEmployees   
    WHERE ManagerID IS NULL  
    UNION ALL  
    SELECT e.ManagerID, e.EmployeeID, e.FirstName, e.LastName, e.Title, EmployeeLevel + 1  
    FROM dbo.#tMyEmployees AS e  
        INNER JOIN DirectReports AS d  
        ON e.ManagerID = d.EmployeeID   
)  
SELECT ManagerID, EmployeeID, FirstName, LastName, Title, EmployeeLevel   
FROM DirectReports  
ORDER BY EmployeeLevel; 

DROP TABLE #tMyEmployees