{{
  config(
    materialized='table'
  )
}}

with orders_source as (
    select * from {{ ref('int_order_order_items') }}
),

results as (
    select
        -- Primary Key
        order_id,

        -- Foreign Keys
        promo_id,
        user_id,
        address_id,
        tracking_id,

        -- Order Info
        status,
        products_purchased,
        total_items_purchased,
        order_cost,
        shipping_cost,
        order_total,
        shipping_service,
        estimated_delivery_at,
        delivered_at,

        -- Calculations
        datediff('day', created_at, estimated_delivery_at)      as est_days_to_delivery,
        datediff('day', created_at, delivered_at)               as actual_days_to_delivery,
        datediff('day', estimated_delivery_at, delivered_at)    as delivery_estimate_error

    from orders_source
)

select * from results
