with film_category as (
    select * 
    from {{source('pagila', 'film_category')}}
),

category as (
    select *
    from {{source('pagila', 'category')}}
), 

full_film_category as (
    select fc.film_id, string_agg(c.name, ', ') as categories
    from film_category fc 
    join category c on fc.category_id = c.category_id
    group by fc.film_id
),

inventory as (
    select film_id, count(*) as inventory_count
    from {{ref('stg_inventory')}}
    group by film_id
),

film as (
    select * 
    from {{ref('stg_films')}}
),

rentals as (
    select *
    from {{ref('stg_rentals')}}
), 

film_rented as (
    select i.film_id, count(*) as times_rented
    from {{ref('stg_inventory')}} i
    join rentals r on i.inventory_id = r.inventory_id
    group by i.film_id
),

rating_description as (
    select * 
    from {{ref('rating_descriptions')}}
)

select f.film_id, f.title, ffc.categories, f.rating, rd.description, 
    f.rental_rate, coalesce(i.inventory_count, 0) as inventory_count,
    coalesce(fr.times_rented, 0) as times_rented,
    (coalesce(i.inventory_count, 0) > 0) as is_available
from film f 
left join full_film_category ffc on f.film_id = ffc.film_id
left join inventory i on f.film_id = i.film_id
left join rating_description rd on f.rating = rd.rating
left join film_rented fr on f.film_id = fr.film_id