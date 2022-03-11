SELECT 
order_id,
product_id,
quantity
FROM {{ source('greenery', 'order_items') }}
