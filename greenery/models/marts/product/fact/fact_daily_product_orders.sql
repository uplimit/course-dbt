{{
    config(
        materialized = 'table'
        , unique_key = 'order_product_date_key'
    )
}}

/*
Grain/primary key : One row per product per (order) date
Stakeholders : Product Team (Product Manager X)
Purpose : Report on daily product orders tthat were delivered
*/

select 
    o.product_id 
    , o.product_name 
    , o.product_price 
    , date(o.order_created_at) as order_created_date
    , concat_ws('-', o.product_id, order_created_date) as order_product_date_key
    -- aggregates
    , count(distinct o.order_id) as count_of_daily_product_orders
    , sum(o.order_product_quantity) as count_of_daily_product_quantity
    , sum(o.product_price * o.order_product_quantity) as daily_product_order_value

from {{ ref('int_orders') }} o 

where o.order_status = 'delivered'

group by all 
