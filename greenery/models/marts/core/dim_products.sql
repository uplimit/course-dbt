
{{
  config(
    materialized='table'
  )
}}

with products_ordered as(
    SELECT 
        product_id,
        sum(quantity) as num_products_ordered
FROM {{ source('raw', 'order_items') }}
GROUP BY 1)

select 
    pr.product_id,
    pr.name as product_name,
    pr.price,
    pr.inventory,
    pc.num_products_ordered
FROM {{ ref('stg_products') }} pr
LEFT JOIN products_ordered pc
ON pr.product_id=pc.product_id