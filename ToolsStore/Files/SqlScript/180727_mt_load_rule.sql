USE ToolsStore
GO


--
--drop mt_load_method
--
DROP TABLE dbo.MT_LOAD_METHOD;
GO


--
--drop mt_load_parameter
--
DROP TABLE dbo.MT_LOAD_PARAMETER;
GO


--
--drop mt_load_rule
--
DROP TABLE dbo.MT_LOAD_RULE
GO


--
--create mt_load_rule
--
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE dbo.MT_LOAD_RULE(
	LoadRuleId  bigint IDENTITY(1,1) NOT NULL,
	Code        nvarchar(50) NOT NULL,
	FileName    nvarchar(100) NOT NULL,
	IsActive    bit NOT NULL,
	MethodLoad  nvarchar(100) NOT NULL,
	PathToXsd   nvarchar(250) NOT NULL,	
	XsdName     nvarchar(100) NOT NULL,	
	Descr       nvarchar(250) NOT NULL,	
	Ord         int NOT NULL,
 CONSTRAINT PK_MT_LOAD_RULE PRIMARY KEY CLUSTERED 
(
	LoadRuleId ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO

--
--insert mt_load_rule
--
INSERT INTO dbo.MT_LOAD_RULE (Code, FileName, IsActive, MethodLoad, PathToXsd, XsdName, Descr, Ord)
     VALUES ('Category', 'Category.xml', 1, 'LoadCategory', '\xsd\', 'Category.xsd', 'Категории', 1);
INSERT INTO dbo.MT_LOAD_RULE (Code, FileName, IsActive, MethodLoad, PathToXsd, XsdName, Descr, Ord)
     VALUES ('Vat', 'Vat.xml', 1, 'LoadVat', '\xsd\', 'Vat.xsd', 'НДС', 2);
GO