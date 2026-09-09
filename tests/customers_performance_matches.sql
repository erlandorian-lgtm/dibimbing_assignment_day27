with mart_customer_performance as (
    select sum(total_rental) as total_rentals,
    sum(lifetime_total_payment) as total_amount
    from {{ref('mart_customer_performance')}}
),

rentals as (
    select count(*) as total_rentals
    from {{ref('stg_rentals')}}
),

payments as (
    select sum(amount) as total_amount 
    from {{ref('stg_payments')}}
)

select * 
from mart_customer_performance, rentals, payments
where mart_customer_performance.total_rentals != rentals.total_rentals or
    mart_customer_performance.total_amount != payments.total_amount 