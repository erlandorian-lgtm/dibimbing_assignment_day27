with payments as (
    select * 
    from {{ref('stg_payments')}}
),

customers as (
    select customer_id, 
    concat(first_name, ' ', last_name) as customer_name
    from {{ref('stg_customers')}}
),

rental_inventory as (
    select r.rental_id, r.customer_id, i.film_id, i.store_id, r.staff_id
    from {{ref('stg_rentals')}} r 
    left join {{ref('stg_inventory')}} i on r.inventory_id = i.inventory_id 
),

film as (
    select film_id, title as film_title
    from {{ref('stg_films')}}
)

select p.payment_id, p.paid_at, p.paid_at::date as paid_date, c.customer_id, c.customer_name, ri.staff_id,
    ri.store_id, ri.rental_id, ri.film_id, f.film_title, p.amount
from payments p 
left join customers c on p.customer_id = c.customer_id 
left join rental_inventory ri on p.rental_id = ri.rental_id
left join film f on ri.film_id = f.film_id