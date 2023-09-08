
{{ config(materialized = 'view') }}

WITH orders AS (
    SELECT * FROM {{ ref('stg_orders') }}
)

, promos AS (
    SELECT * FROM {{ ref('stg_promos') }}
)
 
SELECT 
  orders.*
  , case
        when orders.promo_id is null then 'N'
        else 'Y'
    end as is_promo_inc
  , promos.discount as discount_amount
  , case
      when row_number() over (partition by user_id order by created_at) = 1 then 'first_order_from_customer'
      else 'recurrent_order_from_customer'
    end as customer_type
FROM orders
LEFT JOIN promos ON orders.promo_id = promos.promo_id
