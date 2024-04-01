{{
    config(
        materialized = 'table'
        , unique_key = 'order_item_id'
    )
}}
/*
Grain/primary key : One row per order_item_id
Stakeholders : Product Team (Product Manager X)
Purpose : Understand order data by collating all related dimensions/facts 
ToDo: replace all select * in the model with a jinja list 
*/

-- enrich order data
select 
    -- orders 
    orders.order_id 
    , orders.created_at as order_created_at 
    , orders.order_cost 
    , orders.shipping_cost as order_shipping_cost 
    , orders.status as order_status
    , orders.order_total 
    , orders.estimated_delivery_at as order_estimated_delivery_at 
    , orders.delivered_at as order_delivered_at 
    , case when order_delivered_at <= order_estimated_delivery_at then true else false end as was_delivered_on_time
    -- promo 
    , case when promo.promo_id is not null then true else false end as order_has_promo
    , promo.discount as promo_discount
    , promo.status as promo_status
    -- order items 
    , order_item.order_item_id
    , order_item.product_id 
    , order_item.quantity as order_product_quantity 
    -- products 
    , product.product_name 
    , product.product_price

from {{ ref('postgres__orders') }} orders

left join {{ ref('postgres__promos') }} promo
    on orders.promo_id = promo.promo_id 

left join {{ ref('postgres__order_items') }} order_item
    on orders.order_id = order_item.order_id 

left join {{ ref('int_products') }} product
    on order_item.product_id = product.product_id 
