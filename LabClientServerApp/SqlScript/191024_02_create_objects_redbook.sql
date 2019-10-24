USE RedBook
GO

SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE dbo.Animals(
	AnimalCode int NOT NULL,
	Name nvarchar(50) NOT NULL,
	Squad nvarchar(50) NOT NULL,
	Type nvarchar(50) NULL,
	TypicalWeight decimal(18,3) NOT NULL,
PRIMARY KEY CLUSTERED 
(
	AnimalCode ASC
) ON [PRIMARY],
UNIQUE NONCLUSTERED 
(
	AnimalCode ASC,
	Name ASC
) ON [PRIMARY]
) ON [PRIMARY]

GO

ALTER TABLE dbo.Animals ADD DEFAULT ((1)) FOR TypicalWeight
GO

ALTER TABLE dbo.Animals  WITH CHECK ADD CHECK  ((TypicalWeight>(0)))
GO


