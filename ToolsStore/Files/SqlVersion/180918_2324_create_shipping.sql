USE [ToolsStore]
GO

CREATE TABLE [dbo].[RS_SHIPPING]
(
	[ShippingId] [bigint] IDENTITY(1,1) NOT NULL,
	[Name] [nvarchar](250) NOT NULL,
	[Line1] [nvarchar](250) NOT NULL,
	[Line2] [nvarchar](150) NULL,
	[Line3] [nvarchar](150) NULL,
	[City]  [nvarchar](100) NOT NULL,
	[State] [nvarchar](100) NOT NULL,
	[Zip] [nvarchar](50) NULL,
	[Country] [nvarchar](100) NOT NULL,
	[GiftWrap] [bit] NOT NULL,
 CONSTRAINT [PK_RS_SHIPPING] PRIMARY KEY CLUSTERED ([ShippingId])
) ON [PRIMARY]