USE ToolsStore
GO

select ordr.OrderId, ordr.Surname, ordr.Name, ordr.Phone, ordr.Email,
       crt.CartId, crt.ProductId, pr.Name as ProductName, eq.Name as EquipmentName,
	   crt.PriceId, case when prc.PriceWithVat is not null then prc.PriceWithVat else 0 end as Price,
	   crt.Quantity,
	   case when prc.PriceWithVat is not null then prc.PriceWithVat else 0 end * crt.Quantity as SumItem,
	   (select SUM(case when price.PriceWithVat is not null then price.PriceWithVat else 0 end * cart.Quantity)
	    from RS_CART cart
		     join RS_PRODUCT prod on cart.ProductId = prod.ProductId
			 left join RS_PRICE price on cart.PriceId = price.PriceId
	    where cart.OrderId = ordr.OrderId) as SumTotal
from RS_ORDER ordr
     join RS_CART crt on ordr.OrderId = crt.OrderId
	 join RS_PRODUCT pr on crt.ProductId = pr.ProductId
	 join SK_EQUIPMENT eq on pr.EquipmentId = eq.EquipmentId
	 left join RS_PRICE prc on crt.PriceId = prc.PriceId;