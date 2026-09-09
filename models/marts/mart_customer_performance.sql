with customers as (
    select *
    from {{ref('int_dim_customers')}}
)

select customer_id, customer_name, coalesce(total_rentals,0) as total_rental,
 first_rented_at, latest_rented_at, lifetime_total_payment,
 coalesce(round(lifetime_total_payment / nullif(total_rentals,0), 2),0) as average_payment
from customers 
