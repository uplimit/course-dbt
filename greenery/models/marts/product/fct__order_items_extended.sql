 {{
  config(
    materialized='table'
  )
}}

WITH order_items_extended AS (
    SELECT
          stgoi.order_id
        , stgoi.product_id
        , stgoi.quantity
        , dpr.price
        , stgpo.promo_id
        , dpm.discount AS promo_discount
    FROM {{ ref('stg_postgres__order_items') }} AS stgoi
    JOIN {{ ref('dim__products') }} AS dpr ON stgoi.product_id = dpr.product_id
    JOIN {{ ref('stg_postgres__orders') }} AS stgpo ON stgoi.order_id = stgpo.order_id
    LEFT JOIN {{ ref('dim__promos') }} AS dpm ON stgpo.promo_id = dpm.promo_id
)

SELECT 
    * 
FROM order_items_extended