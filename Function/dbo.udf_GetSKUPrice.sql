/*
    Функция для расчёта средней цены товара (SKU) на основе данных из таблицы dbo.Basket.
    Возвращает 0, если для товара нет записей в корзине
*/
create function dbo.udf_GetSKUPrice(@ID_SKU int)
returns decimal(18,2)
as
begin
    declare @Price decimal(18,2);
    
    select @Price = SUM([Value]) / SUM(Quantity)
    from dbo.Basket
    where ID_SKU = @ID_SKU;
    
    return ISNULL(@Price, 0);
end;

