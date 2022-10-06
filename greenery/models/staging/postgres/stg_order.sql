SELECT
    order_id
    , user_id
    , promo_id
    , address_id
    , created_at AS order_created_at
    , order_cost
    , shipping_cost
    , order_total AS total_order_cost
    , tracking_id
    , shipping_service
    , estimated_delivery_at
    , delivered_at AS actual_delivered_at
    , status AS order_status
FROM {{ source('postgres', 'orders') }} 