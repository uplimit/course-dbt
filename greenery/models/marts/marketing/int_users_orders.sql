
{{
  config(
    materialized = 'table'
  )
}}

select 
    stg_greenery__users.user_id
    , stg_greenery__users.first_name
    , stg_greenery__users.last_name
    , stg_greenery__users.email
    , stg_greenery__users.phone_number
    , stg_greenery__users.created_at_utc AS user_created_at_utc
    , stg_greenery__users.updated_at_utc AS user_updated_at_utc
    , stg_greenery__users.address_id
    , int_orders_promos.order_id
    , int_orders_promos.created_at_utc AS order_created_at_utc 
    , int_orders_promos.order_cost
    , int_orders_promos.shipping_cost
    , int_orders_promos.order_total
    , int_orders_promos.tracking_id
    , int_orders_promos.shipping_service
    , int_orders_promos.estimated_delivery_at_utc
    , int_orders_promos.delivered_at_utc
    , int_orders_promos.order_status
    , int_orders_promos.has_promo_applied
    , stg_greenery__addresses.address
    , stg_greenery__addresses.zipcode
    , stg_greenery__addresses.state
    , stg_greenery__addresses.country
from {{ ref('stg_greenery__users') }}
left join {{ ref('int_orders_promos') }}
on stg_greenery__users.user_id = int_orders_promos.user_id
left join {{ ref('stg_greenery__addresses') }}
on stg_greenery__users.address_id = stg_greenery__addresses.address_id