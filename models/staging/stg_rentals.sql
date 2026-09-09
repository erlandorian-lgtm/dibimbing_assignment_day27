select 
    rental_id,
    inventory_id,
    customer_id,
    staff_id,
    rental_date::timestamp as rented_at,
    return_date::timestamp as return_at 
from {{source('pagila', 'rental')}}