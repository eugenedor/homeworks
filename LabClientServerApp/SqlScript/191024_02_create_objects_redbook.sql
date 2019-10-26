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
CONSTRAINT PK_Animals PRIMARY KEY CLUSTERED 
(
	AnimalCode ASC
) ON [PRIMARY],
CONSTRAINT UQ_Animals UNIQUE NONCLUSTERED 
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

CREATE TABLE dbo.Countries(
	CountryCode int NOT NULL,
	Name nvarchar(25) NOT NULL,
	Mainland nvarchar(25) NOT NULL,
	Capital nvarchar(25) NOT NULL,
	AmountNationalReserves decimal(18, 3) NULL,
PRIMARY KEY CLUSTERED 
(
	CountryCode ASC
) ON [PRIMARY],
UNIQUE NONCLUSTERED 
(
	CountryCode ASC
) ON [PRIMARY]
) ON [PRIMARY]
GO

ALTER TABLE dbo.Countries ADD  DEFAULT ((1)) FOR AmountNationalReserves
GO

ALTER TABLE dbo.Countries  WITH CHECK ADD CHECK  ((AmountNationalReserves>(0)))
GO

CREATE TABLE dbo.Habitat(
	AnimalCode int NOT NULL,
	CountryCode int NOT NULL,
	Population int NOT NULL
) ON [PRIMARY]

GO

ALTER TABLE dbo.Habitat  WITH CHECK ADD  CONSTRAINT FK_Habitat_Animals FOREIGN KEY(AnimalCode)
REFERENCES dbo.Animals (AnimalCode)
GO

ALTER TABLE dbo.Habitat CHECK CONSTRAINT FK_Habitat_Animals
GO

ALTER TABLE dbo.Habitat  WITH CHECK ADD  CONSTRAINT FK_Habitat_Countries FOREIGN KEY(CountryCode)
REFERENCES dbo.Countries (CountryCode)
GO

ALTER TABLE dbo.Habitat CHECK CONSTRAINT FK_Habitat_Countries
GO