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
        promo_id,
        address_id,
        created_at as created_at_utc,
        order_cost,
        shipping_cost,
        order_total,
        tracking_id,
        shipping_service,
        estimated_delivery_at as estimated_delivery_at_utc,
        delivered_at as delivered_at_utc,
        status
    FROM sources
)

select * from rename_recast