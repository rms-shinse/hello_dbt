with sales_by_person as (
    select
        who_selled as person,
        SUM(amount)
    from contracts
    group by who_selled
)

select * from sales_by_person