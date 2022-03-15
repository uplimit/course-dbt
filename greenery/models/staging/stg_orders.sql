SELECT
    order_id,
    promo_id AS promotion_id,
    user_id,
    address_id,
    order_cost,
    shipping_cost,
    order_total,
    tracking_id,
    shipping_service,
    status,
    created_at AS created_at_utc,
    estimated_delivery_at AS estimated_delivery_at_utc,
    delivered_at AS delivered_at_utc
FROM {{ source('tutorial', 'orders') }}
