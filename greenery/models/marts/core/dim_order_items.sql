{{
  config(
    materialized='table'
  )
}}
    select 
        order_id,
        product_id,
        quantity
FROM {{ ref('stg_order_items') }}