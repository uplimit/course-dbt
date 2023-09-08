
{{ config(materialized = 'view') }}

WITH orders AS (
    SELECT * FROM {{ ref('stg_orders') }}
)

SELECT 
    {{ dbt_utils.surrogate_key
      ([
        'orders.created_at'
        , 'orders.promo_id'
      ]) 
    }} as unique_key
  , DATE(created_at) AS created_at_date
  , promo_id
  , count(*)
FROM orders
WHERE promo_id IS NOT NULL
GROUP BY 1,2,3
ORDER BY 1