WITH base AS(
  SELECT
    *
  FROM {{source('postgres','orders')}}
),

rename_recast AS(
  SELECT
    order_id AS order_guid,
    promo_id,
    user_id AS user_guid,
    created_at,
    order_cost,
    shipping_cost,
    order_total,
    tracking_id AS tracking_guid,
    shipping_service,
    estimated_delivery_at,
    delivered_at,
    status
  FROM base
)

SELECT * FROM rename_recast
