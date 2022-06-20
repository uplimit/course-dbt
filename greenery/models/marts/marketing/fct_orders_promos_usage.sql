-- high level usage data for promo codes
{{
  config(
    materialized = 'table'
  )
}}

select 
    order_id
    , has_promo_applied
    , promo_active_status
    , promo_id
    , created_at_utc
    , delivered_at_utc
    , estimated_delivery_at_utc
    , order_status
    , order_cost
    , shipping_cost
    , order_total
    , discount_amount
    , 1 - ((order_total - discount_amount)/order_total) AS discount_percent_from_total
    , shipping_service
from {{ ref( 'int_orders_promos' )}}