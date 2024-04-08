/*
    Триггер для обработки событий INSERT и UPDATE в таблице dbo.Basket. 
    Применяет скидку 5% к товарам, количество которых в корзине больше или равно 2 
*/
create trigger dbo.TR_Basket_insert_update
on dbo.Basket
after insert, update
as
begin
    with cte_SkusWithQuantityMoreThanTwo as (
        select ID_SKU, sum(Quantity) as TotalQuantity
        from inserted
        group by ID_SKU
        having sum(Quantity) >= 2
    )
    
    update b
    set DiscountValue = i.Value * 0.05
    from dbo.Basket b
    inner join inserted i on b.ID = i.ID
    inner join cte_SkusWithQuantityMoreThanTwo cte on b.ID_SKU = cte.ID_SKU
    left join deleted d on b.ID = d.ID
    where d.ID is null;
    
    update b
    set DiscountValue = 0
    from dbo.Basket b
    inner join inserted i on b.ID = i.ID
    left join deleted d on b.ID = d.ID
    left join cte_SkusWithQuantityMoreThanTwo cte on b.ID_SKU = cte.ID_SKU
    where d.ID is not null
        and cte.ID_SKU is null;
end;