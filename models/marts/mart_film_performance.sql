with films as (
    select *
    from {{ref('int_dim_films')}}
),

payments as (
    select *
    from{{ref('fact_payments')}}
)

select f.film_id, f.title, f.categories, f.inventory_count, 
f.times_rented, coalesce(sum(p.amount),0) as total_revenue
from films f
left join payments p on f.film_id = p.film_id
group by f.film_id, f.title, f.categories, f.inventory_count, f.times_rented
  
