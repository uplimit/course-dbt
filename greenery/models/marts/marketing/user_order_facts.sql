 {{
  config(
    materialized='table'
  )
}}

SELECT
    u.user_id,
    u.created_at user_created_at,
    orders.order_ct,
    orders.first_order_created_at,
    orders.last_order_created_at,
    orders.all_products_ordered,
    orders.number_distinct_products_ordered,
    orders.total_order_costs,
    orders.total_order_revenue
FROM {{ ref('staging_postgres_users') }} u 
LEFT JOIN 
    (SELECT
        user_id,
        count(distinct order_id) order_ct,
        min(created_at) as first_order_created_at,
        max(created_at) as last_order_created_at,
        array_union_agg(products_ordered) all_products_ordered,
        array_size(all_products_ordered) number_distinct_products_ordered,
        sum(order_cost) total_order_costs,
        sum(order_total) total_order_revenue
     FROM {{ ref('order_facts') }}
     group by 1
 ) orders on orders.user_id = u.user_id