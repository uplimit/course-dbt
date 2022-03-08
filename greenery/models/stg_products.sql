SELECT 
product_id AS product_id,
name AS name,
price AS price,
inventory AS inventory
FROM {{ source('greenery', 'products') }}
