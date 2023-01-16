{{
  config(
    materialized='table'
  )
}}

with src_orders as (
    select * from {{ source('postgres','orders' )}}
)

, renamed_recast as (
    SELECT
        ORDER_ID as order_guid
        , USER_ID as user_guid
        , PROMO_ID as promo_desc
        , ADDRESS_ID as address_guide
        , CREATED_AT::timestampntz as created_at_utc
        , ORDER_COST
        , SHIPPING_COST
        , ORDER_TOTAL
        , TRACKING_ID as tracking_guid
        , SHIPPING_SERVICE
        , ESTIMATED_DELIVERY_AT::timestampntz as estimated_delivery_at_utc
        , DELIVERED_AT::timestampntz as delivered_at_utc
        , STATUS
    from src_orders
)

select * from renamed_recast