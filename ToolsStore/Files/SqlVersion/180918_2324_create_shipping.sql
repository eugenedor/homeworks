USE [ToolsStore]
GO

CREATE TABLE [dbo].[RS_ORDER]
(
	[OrderId] [bigint] IDENTITY(1,1) NOT NULL,
	[Name] [nvarchar](250) NOT NULL,
	[Line1] [nvarchar](250) NOT NULL,
	[Line2] [nvarchar](150) NULL,
	[Line3] [nvarchar](150) NULL,
	[City]  [nvarchar](100) NOT NULL,
	[State] [nvarchar](100) NOT NULL,
	[Zip] [nvarchar](50) NULL,
	[Country] [nvarchar](100) NOT NULL,
	[GiftWrap] [bit] NOT NULL,
	[Phone] [nvarchar](50) NOT NULL,
	[Email] [nvarchar](50) NULL,
	[DateOrder] [datetime] NULL,
 CONSTRAINT [PK_RS_ORDER] PRIMARY KEY CLUSTERED ([OrderId])
) ON [PRIMARY]
GO


CREATE TABLE [dbo].[RS_CART]
(
	[CartId] [bigint] IDENTITY(1,1) NOT NULL,
	[OrderId] [bigint] NOT NULL,
	[ProductId] [bigint] NOT NULL,
	[PriceId] [bigint] NULL,
	[Quantity] [int] NOT NULL
CONSTRAINT [PK_RS_CART] PRIMARY KEY CLUSTERED ([CartId])
) ON [PRIMARY]
GO

CREATE INDEX [FK_RS_CART_RS_ORDER]
  ON [dbo].[RS_CART] ([OrderId])
  ON [PRIMARY]
GO

ALTER TABLE [dbo].[RS_CART]
  ADD CONSTRAINT [FK_RS_CART_RS_ORDER] FOREIGN KEY ([OrderId]) REFERENCES [dbo].[RS_ORDER] ([OrderId])
GO

CREATE INDEX [FK_RS_CART_RS_PRODUCT]
  ON [dbo].[RS_CART] ([ProductId])
  ON [PRIMARY]
GO

ALTER TABLE [dbo].[RS_CART]
  ADD CONSTRAINT [FK_RS_CART_RS_PRODUCT] FOREIGN KEY ([ProductId]) REFERENCES [dbo].[RS_PRODUCT] ([ProductId])
GO

CREATE INDEX [FK_RS_CART_RS_PRICE]
  ON [dbo].[RS_CART] ([PriceId])
  ON [PRIMARY]
GO

ALTER TABLE [dbo].[RS_CART]
  ADD CONSTRAINT [FK_RS_CART_RS_PRICE] FOREIGN KEY ([PriceId]) REFERENCES [dbo].[RS_PRICE] ([PriceId])
GO