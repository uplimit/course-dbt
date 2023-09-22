{{
  config(
    materialized='table'
  )
}}

SELECT 
order_date, 
user_id,
COUNT(DISTINCT order_id) as orders, 
SUM(order_total) as order_spent

FROM {{ref('fact_orders')}}

GROUP BY 1,2
