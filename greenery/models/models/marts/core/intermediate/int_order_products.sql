{{ config (materialized='table')}}

SELECT
    order_id,
    order_items_surrogate_key,
    o.product_id,
    product_name,
    price,
    inventory as available_inventory,
    quantity as quanity_purchased
FROM {{ref('stg_greenery_order_items')}} o
JOIN {{ref('stg_greenery_products')}} p ON p.product_id = o.product_id