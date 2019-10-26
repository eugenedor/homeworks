USE RedBook
GO

SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE dbo.Animals (
AnimalCode INT NOT NULL,
Name NVARCHAR(50) NOT NULL,
Squad NVARCHAR(50) NOT NULL,
Type NVARCHAR(50) NULL,
TypicalWeight DECIMAL(18,3) NOT NULL DEFAULT 1,
UNIQUE (AnimalCode, Name),
PRIMARY KEY (AnimalCode),
CHECK (TypicalWeight > 0)
)
GO

CREATE TABLE dbo.Countries (
CountryCode INT NOT NULL,
Name NVARCHAR(25) NOT NULL,
Mainland NVARCHAR(25) NOT NULL,
Capital NVARCHAR(25) NOT NULL, 
AmountNationalReserves DECIMAL(18,3) NULL DEFAULT 1,
UNIQUE (CountryCode),
PRIMARY KEY (CountryCode),
CHECK (AmountNationalReserves > 0)
)
GO

CREATE TABLE Habitat (
AnimalCode INT NOT NULL,
CountryCode INT NOT NULL,
Population INT NOT NULL
CONSTRAINT FK_Habitat_Animals
FOREIGN KEY (AnimalCode)
REFERENCES Animals (AnimalCode),
CONSTRAINT FK_Habitat_Countries
FOREIGN KEY (CountryCode)
REFERENCES Countries (CountryCode)
)
GO
