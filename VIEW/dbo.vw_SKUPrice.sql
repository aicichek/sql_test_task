-- Представление для получения информации о товарах (SKU) и их средней цене
create view dbo.vw_SKUPrice
as
select 
    s.ID
    ,s.Code
    ,s.Name
    ,dbo.udf_CalculateAverageSkuPrice(s.ID) as Price
from dbo.SKU s;
