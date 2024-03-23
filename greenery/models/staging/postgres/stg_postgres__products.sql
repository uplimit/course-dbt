SELECT PRODUCT_ID, NAME, PRICE, INVENTORY
FROM {{source('postgres', 'products')}}