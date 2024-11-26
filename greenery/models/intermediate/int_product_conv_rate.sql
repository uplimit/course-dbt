
{{
  config(
    materialized='table'
  )
}}

with ts as (
select 
    split_part(page_url, '/',5) product_id,
    products.name product_name,
    count( distinct events.session_id) total_sessions
from {{ ref('stg_events')}} events
join {{ ref('stg_products')}} products
on events.product_id = products.product_id
group by 1,2),

cs as (
select 
    orders.product_id,
    products.name product_name,
    count(  orders.order_id) total_orders
from {{ ref('stg_order_items')}} orders
left join {{ ref('stg_products')}} products
on orders.product_id = products.product_id
group by 1,2)

select 
ts.product_id,
ts.product_name,
cs.total_orders,
ts.total_sessions,
cs.total_orders/ts.total_sessions conversion_rate
from ts
left join cs
on ts.product_id = cs.product_id
order by conversion_rate desc 