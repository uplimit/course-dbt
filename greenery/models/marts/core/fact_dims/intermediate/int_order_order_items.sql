{{
  config(
    materialized='table'
  )
}}

with orders_source as (
    select * from {{ ref('stg_postgres_orders') }}
),

order_items as (
    select * from {{ ref('stg_postgres_order_items') }}
),

order_details as (
    select
      order_id,

      count(distinct product_id)  as products_purchased,
      sum(quantity)               as total_items_purchased

      from order_items
      group by 1
),

results as (
    select
        -- Primary Key
        o.order_id,

        -- Foreign Keys
        o.promo_id,
        o.user_id,
        o.address_id,
        o.tracking_id,

        -- Order Info
        o.order_status,
        od.products_purchased,
        od.total_items_purchased,
        o.order_cost,
        o.shipping_cost,
        o.total_cost,
        o.carrier,
        o.created_at,
        o.estimated_delivery_at,
        o.delivered_at
        

    from orders_source o
    left join order_details od
        on o.order_id = od.order_id

)

select * from results