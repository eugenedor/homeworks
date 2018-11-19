USE ToolsStore;
GO

--select 1.786, floor(1.786), ceiling(1.786), cast(round(1.786, 2) as decimal(17,2))
--select 100 * cast((cast((100+18) as decimal(17,2))/100) as decimal(17,2))
--select cast(118 as decimal(17,2))*100/118

declare @price decimal(17,2),
        @vat decimal(17,2);

set @price = cast(1616 as decimal(17,2));
set @vat = 18;

select t.PriceWithVat, 
       t.PriceWithoutVat,
	   t.Vat,
	   cast(round(t.PriceWithoutVat*(1+ cast(@vat as decimal(17,2))/100),2) as decimal(17,2)) PriceWithVatTest
from
(select @price as PriceWithVat,
        cast(round(@price*100/(100 + @vat), 2) as decimal(17,2)) as PriceWithoutVat,
	    @vat as Vat) t


select * from RS_PRICE order by PriceId desc;