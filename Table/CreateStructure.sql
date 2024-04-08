-- Таблица для хранения информации о товарах (SKU)
create table dbo.SKU (
    ID int IDENTITY(1,1) primary key
    ,Code as 's' + CAST(ID as varchar(10)) persisted
    ,[Name] varchar(255) not null
    ,Constraint UQ_Sku_Code unique (Code)
);

-- Таблица для хранения информации о семьях
create table dbo.Family (
    ID int IDENTITY(1,1) primary key
    ,SurName varchar(255) not null
    ,BudgetValue decimal(18,2) not null
);

-- Таблица для хранения информации о корзинах покупок
create table dbo.Basket (
    ID int IDENTITY(1,1) primary key
    ,ID_Sku int foreign key references dbo.Sku(ID) not null
    ,ID_Family int foreign key references dbo.Family(ID) not null
    ,Quantity int not null check (Quantity >= 0)
    ,[Value] decimal(18,2) not null check (Value >= 0)
    ,PurchaseDate date not null default GETDATE()
    ,DiscountValue decimal(18,2) not null default 0
);