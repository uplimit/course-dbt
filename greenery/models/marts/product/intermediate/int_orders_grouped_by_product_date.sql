{{
  config(
    materialized='table'
  )
}}


with stg_orders as (
    select * from {{ref('stg_orders')}}
)

, stg_products as (
    select * from {{ref('stg_products')}}
)

, stg_order_items as (
    select * from {{ref('stg_order_items')}}
)


, orders_items_dates as (
    select stg_order_items.product_id 
    , created_at::date as created_at_date  
    from stg_order_items 
    left join stg_orders 
        on stg_order_items.order_id  = stg_orders.order_id 
    group by 1, 2
)


select 
stg_products.product_id 
, orders_items_dates.created_at_date
, min(stg_products.name) as product_name 
, count(distinct stg_order_items.order_id) as num_of_orders 
, sum(quantity) as num_of_items 
, sum(price) as total_rev_no_discount --- this field doesn't take into account if someone used a discount code  
from stg_products 
left join stg_order_items 
    on stg_products.product_id = stg_order_items.product_id 
left join orders_items_dates 
    on orders_items_dates.product_id  = stg_products.product_id 
group by stg_products.product_id, orders_items_dates.created_at_date
order by stg_products.product_id asc, orders_items_dates.created_at_date asc 