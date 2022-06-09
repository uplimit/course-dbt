{{
    config(
        materialized = 'view'
    )
}}


with order_source as (
    select * from {{ source('src_greenery__orders', 'orders') }}
)

, renamed_recast as (
    SELECT
    order_id as order_guid
    , promo_id as promo_guid
    , user_id as user_guid
    , address_id as address_guid
    , created_at as order_created_at_utc
    , order_cost
    , shipping_cost
    , order_total
    , tracking_id as tracking_guid
    , shipping_service
    , estimated_delivery_at as estimated_delivery_at_utc
    , delivered_at as delivered_at_utc
    , status as order_status
    from order_source
)

select * from renamed_recast