USE ToolsStore
GO

ALTER VIEW dbo.V_CART
AS 
SELECT crt.CartId, crt.OrderId,
       crt.ProductId, 
	   pr.Name ProductName, 
	   eq.Name EquipmentName,
	   crt.PriceId, 
	   CASE WHEN prc.PriceWithVat IS NOT NULL THEN prc.PriceWithVat ELSE 0 END Price,
	   crt.Quantity,
	   CASE WHEN prc.PriceWithVat IS NOT NULL THEN prc.PriceWithVat ELSE 0 END * crt.Quantity Summ
FROM RS_CART crt
	 JOIN RS_PRODUCT pr 
	   ON crt.ProductId = pr.ProductId
	 JOIN SK_EQUIPMENT eq 
	   ON pr.EquipmentId = eq.EquipmentId
	 LEFT JOIN RS_PRICE prc 
	   ON crt.PriceId = prc.PriceId;
GO