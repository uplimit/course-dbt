SELECT 
order_id AS order_id,
product_id AS product_id,
quantity AS quantity
FROM {{ source('greenery', 'order_items') }}
