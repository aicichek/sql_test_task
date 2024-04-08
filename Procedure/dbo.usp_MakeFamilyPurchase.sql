-- Процедура для обработки покупки семьи. Вычитает сумму покупок из бюджета семьи
create procedure dbo.usp_MakeFamilyPurchase
    @FamilySurName varchar(255)
as
begin
    declare @FamilyID int;
    
    select @FamilyID = ID
    from dbo.Family
    where SurName = @FamilySurName;
    
    if @FamilyID is null
    begin
        raiserror('Семьи с фамилией "%s" не существует', 16, 1, @FamilySurName);
        return;
    end;

    ;with cte_FamilyPurchases as (
        select sum([Value]) as TotalPurchaseValue
        from dbo.Basket
        where ID_Family = @FamilyID
    )
    update dbo.Family
    set BudgetValue = BudgetValue - cte_FamilyPurchases.TotalPurchaseValue
    from cte_FamilyPurchases
    where ID = @FamilyID;
end;
