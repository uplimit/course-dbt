{{
  config(
    materialized='view'
  )
}}

with source as (
    select
        *
    from {{ source('postgres', 'orders') }}
)

, reaname_recast as ( 
    SELECT 
        order_id as order_uuid,
        user_id as user_uuid,
        address_id as address_uuid,
        promo_id as promo_name,
        status AS order_status,
        shipping_service,
        tracking_id as order_tracking_uuid,
        order_cost,
        shipping_cost,
        order_total,
        estimated_delivery_at,
        delivered_at,
        created_at as order_created_at
    FROM source
)

select * from reaname_recast


