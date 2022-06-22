{{
  config(
    materialized = 'table'
  )
}}

SELECT
  stg_greenery__orders.order_id
  , stg_greenery__orders.promo_id
  , stg_greenery__orders.user_id
  , stg_greenery__orders.address_id
  , stg_greenery__orders.order_created_at_utc
  , stg_greenery__orders.order_cost
  , stg_greenery__orders.shipping_cost
  , stg_greenery__orders.order_total
  , stg_greenery__orders.tracking_id
  , stg_greenery__orders.shipping_service
  , stg_greenery__orders.order_estimated_delivery_at_utc
  , stg_greenery__orders.order_delivered_at_utc
  , stg_greenery__orders.order_status
  , stg_greenery__promos.discount_amount
  , (CASE WHEN stg_greenery__promos.discount_amount > 0 THEN 1 ELSE 0 END) AS has_promo_applied
  , stg_greenery__promos.promo_active_status
FROM {{ ref('stg_greenery__orders') }}
left join {{ ref('stg_greenery__promos')}}
on stg_greenery__orders.promo_id = stg_greenery__promos.promo_id