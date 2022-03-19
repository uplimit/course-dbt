{{
  config(
    materialized='table'
  )
}}

with stg_orders as (
    
    select * from {{ref('stg_orders') }}
    
)

, order_agg as (
SELECT 
    user_id
    ,  count(order_id) as num_of_orders 
    , count(promo_id) as num_of_promos
    , min(created_at) as first_order_created_at 
    , max(created_at) as last_order_created_at 
    , sum(order_cost) as total_order_cost 
    , sum(shipping_cost) as total_shipping_cost  
    , sum(order_total) as total_order_total --- def need a better name 
FROM stg_orders 
GROUP BY user_id ) 

SELECT *  
FROM order_agg  