-- stg_public__orders.sql

with

source as (

    select * from {{ source('public', 'orders') }}

),

source_standardized as (

    select

          order_id               as order_guid
        , user_id                as user_guid
        , promo_id
        , address_id             as user_address_id
        , created_at             as created_at_utc
        , order_cost
        , shipping_cost
        , order_total
        , tracking_id
        , shipping_service
        , estimated_delivery_at  as estimated_delivery_at_utc
        , delivered_at           as delivered_at_utc
        , status                 as order_status

    from source

)

select * from source_standardized