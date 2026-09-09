with customers as (
    select * 
    from {{ref('stg_customers')}}
),

rentals as (
    select 
        customer_id,
        COUNT(rental_id) as total_rentals,
        MAX(rented_at) as latest_rented_at,
        MIN(rented_at) as first_rented_at
    from {{ref('stg_rentals')}}
    group by customer_id
),

payments as (
    select customer_id,
        sum(amount) as lifetime_total_payment
    from {{ref('stg_payments')}}
    group by customer_id 
)

select c.customer_id, CONCAT(c.first_name, ' ' ,c.last_name) as customer_name,
    coalesce(r.total_rentals, 0) as total_rentals,
    r.first_rented_at, r.latest_rented_at,
    coalesce(p.lifetime_total_payment, 0) as lifetime_total_payment
from customers c
left join rentals r on c.customer_id = r.customer_id
left join payments p on c.customer_id = p.customer_id