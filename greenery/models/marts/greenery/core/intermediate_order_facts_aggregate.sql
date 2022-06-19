{{ 
    config(
        materialized = 'table'
    )  
}}

WITH order_facts AS (
  SELECT 
    user_guid
    , count(distinct order_guid) orders_done
    , min(created_at_utc) first_order_timestamp_utc
    , max(created_at_utc) last_order_timestamp_utc
    , avg(order_cost) avg_order_cost
    , round(avg(order_cost)::int,2) AS rounded_avg_order_cost_usd
    , sum(order_total_cost) total_order_amount_usd 
  FROM 
    {{
      ref('stg_greenery__orders') 
    }}
  GROUP BY user_guid 
)

SELECT 
    * 
FROM 
    order_facts