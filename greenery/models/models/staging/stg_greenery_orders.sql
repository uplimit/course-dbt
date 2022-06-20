{{config(
    materialized='table'
) }}

with sources as (
    select * from {{ source('greenery_src', 'orders') }} as orders
)

, rename_recast as (
    SELECT
        order_id,
        user_id,
        promo_id as promo_code,
        address_id,
        created_at as order_created_at_utc,
        order_cost,
        shipping_cost,
        order_total,
        tracking_id as order_tracking_id,
        shipping_service,
        estimated_delivery_at as order_estimated_delivery_at_utc,
        delivered_at as order_delivered_at_utc,
        status as order_status
    FROM sources
)

select * from rename_recast