{{
  config(
    materialized='table'
  )
}}


SELECT
a.order_id, 
DATE(a.created_at) as created_at,
a.product_id,
b.name as product_name

FROM {{ ref('int_orders') }}  a
LEFT JOIN {{ ref('dim_products') }}  b
ON a.product_id = b.product_id

WHERE a.product_id is not null