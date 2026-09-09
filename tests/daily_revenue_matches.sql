with mart_daily_revenue as (
    select sum(total_revenue) as total_revenue,
    sum(total_payments) as total_payments
    from {{ref('mart_daily_revenue')}}
),

payments as (
    select sum(amount) as total_amount,
    count(*) as total_payments
    from {{ref('stg_payments')}}
)

select *
from mart_daily_revenue, payments
where mart_daily_revenue.total_revenue != payments.total_amount or
    mart_daily_revenue.total_payments != payments.total_payments