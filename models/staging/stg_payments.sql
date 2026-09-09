select 
    payment_id,
    customer_id,
    staff_id,
    rental_id,
    amount,
    payment_date::timestamp as paid_at 
from {{source('pagila','payment')}}