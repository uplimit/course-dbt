SELECT 
order_id AS order_id,
user_id AS user_id,
promo_id AS promo_id,
address_id AS address_id,
created_at AS created_at,
order_cost AS order_cost,
shipping_cost AS shipping_cost,
order_total AS order_total,
tracking_id AS tracking_id,
shipping_service AS shipping_service,
estimated_delivery_at AS estimated_delivery_at,
status AS status
FROM {{ source('greenery', 'orders') }}
