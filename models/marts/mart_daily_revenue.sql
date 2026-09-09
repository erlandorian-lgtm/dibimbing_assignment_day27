with fact_payments as (
    select *
    from {{ref('fact_payments')}}
)

select paid_date, store_id, 
    count(*) as total_payments,
    count(distinct customer_id) as unique_customers,
    sum(amount) as total_revenue
from fact_payments
group by paid_date, store_id