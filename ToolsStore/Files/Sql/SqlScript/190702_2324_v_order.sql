USE ToolsStore
GO

IF EXISTS (SELECT * FROM sys.objects WHERE OBJECT_ID = OBJECT_ID('dbo.V_CART') AND type = N'V')
  DROP VIEW dbo.V_CART
GO

IF EXISTS (SELECT * FROM sys.objects WHERE OBJECT_ID = OBJECT_ID('dbo.V_ORDER') AND type = N'V') --OBJECT_ID('dbo.V_ORDER', 'V') IS NOT NULL
  DROP VIEW dbo.V_ORDER
GO

CREATE VIEW dbo.V_ORDER
AS 
SELECT orc.OrderContentId, orc.OrderId,
       orc.ProductId, 
	   LTRIM(RTRIM(ord.Surname + ' ' +  ord.Name)) OrderName,
	   ord.Phone,
	   pr.Name ProductName, 
	   eq.Name EquipmentName,
	   orc.PriceId, 
	   CASE WHEN prc.PriceWithVat IS NOT NULL THEN prc.PriceWithVat ELSE 0 END Price,
	   orc.Quantity,
	   CASE WHEN prc.PriceWithVat IS NOT NULL THEN prc.PriceWithVat ELSE 0 END * orc.Quantity Summ
FROM RS_ORDER ord
     JOIN RS_ORDER_CONTENT orc
	   ON ord.OrderId = orc.OrderId
	 JOIN RS_PRODUCT pr 
	   ON orc.ProductId = pr.ProductId
	 JOIN SK_EQUIPMENT eq 
	   ON pr.EquipmentId = eq.EquipmentId
	 LEFT JOIN RS_PRICE prc 
	   ON orc.PriceId = prc.PriceId;
GO