{{ 
    config(
        MATERIALIZED = 'table'
    )
}}


WITH orders_source AS 
(
    SELECT
        order_id
        , user_id
        , promo_id
        , address_id
        , created_at
        , order_cost
        , shipping_cost
        , order_total
        , tracking_id
        , shipping_service
        , estimated_delivery_at
        , delivered_at
        , status
    FROM
        {{ source('postgres', 'orders') }}
)


SELECT
    os.order_id
    , os.user_id
    , os.promo_id
    , os.address_id
    , os.created_at
    , os.order_cost
    , os.shipping_cost
    , os.order_total
    , os.tracking_id
    , os.shipping_service
    , os.estimated_delivery_at
    , os.delivered_at
    , os.status
FROM orders_source os