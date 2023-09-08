
{{ config(materialized = 'view') }}

WITH orders AS (
    SELECT * FROM {{ ref('stg_orders') }}
)

, order_items AS (
    SELECT * FROM {{ ref('stg_order_items') }}
)

, products AS (
    SELECT * FROM {{ ref('stg_products') }}
)

SELECT 
  {{ dbt_utils.surrogate_key
      ([
        'orders.created_at'
        , 'order_items.product_id'
      ]) 
    }} as unique_key
  , DATE(orders.created_at) AS created_at_date
  , order_items.product_id
  , products.name
  , sum(quantity) AS total_units_sold
FROM orders
FULL JOIN order_items 
  ON orders.order_id = order_items.order_id
LEFT JOIN products
  ON products.product_id = order_items.product_id
GROUP BY 1,2,3,4
