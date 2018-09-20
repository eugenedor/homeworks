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
GO


CREATE TABLE [dbo].[RS_CART]
(
	[CartId] [bigint] IDENTITY(1,1) NOT NULL,
	[ShippingId] [bigint] NOT NULL,
	[ProductId] [bigint] NOT NULL,
	[PriceId] [bigint] NULL,
	[Quantity] [int] NOT NULL
CONSTRAINT [PK_RS_CART] PRIMARY KEY CLUSTERED ([CartId])
) ON [PRIMARY]
GO

CREATE INDEX [FK_RS_CART_RS_SHIPPING]
  ON [dbo].[RS_CART] ([ShippingId])
  ON [PRIMARY]
GO

ALTER TABLE [dbo].[RS_CART]
  ADD CONSTRAINT [FK_RS_CART_RS_SHIPPING] FOREIGN KEY ([ShippingId]) REFERENCES [dbo].[RS_SHIPPING] ([ShippingId])
GO