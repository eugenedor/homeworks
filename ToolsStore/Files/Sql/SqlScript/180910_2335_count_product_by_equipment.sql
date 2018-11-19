select eq.Name as EquipmentName, 
	   pr.cntProduct as cntProduct,
	   ct.Name as CategoryName
from SK_EQUIPMENT eq
     join (select prd.EquipmentId, count(prd.ProductId) as cntProduct
		   from RS_PRODUCT prd
		   group by prd.EquipmentId
		   having count(prd.ProductId) >= 3) pr
	   on  eq.EquipmentId = pr.EquipmentId
     join CT_CATEGORY ct
	   on eq.CategoryId = ct.CategoryId
order by pr.cntProduct desc;