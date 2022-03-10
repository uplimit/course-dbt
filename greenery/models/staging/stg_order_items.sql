select 
    order_id,
    product_id,
    quantity

from {{ source('greenery','order_items')}}