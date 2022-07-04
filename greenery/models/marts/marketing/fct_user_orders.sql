SELECT 
    orders.order_id
    , orders.user_id
    , users.is_repeat_customer
    , users.number_of_user_orders
    , users.first_name
    , users.last_name
    , users.email
    , users.phone_number
    , users.user_created_at_utc
    , orders.order_address_id
    , orders.order_created_at_utc
    , CASE WHEN orders.promo_id IS NOT NULL THEN true ELSE false END AS has_promo_code
    , promos.promo_id
    , promos.discount AS promo_discount
    , orders.order_cost
    , orders.shipping_cost
    , orders.order_total_cost
    , orders.order_status
    , orders.tracking_id
    , orders.shipping_service
    , orders.estimated_delivery_at_utc
    , orders.delivered_at_utc
FROM {{ ref('int_orders') }} AS orders
JOIN {{ ref('int_users' )}} AS users ON users.user_id = orders.user_id
LEFT JOIN {{ ref('stg_promos__promos')}} AS promos ON orders.promo_id = promos.promo_id