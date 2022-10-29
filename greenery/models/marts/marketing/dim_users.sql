{{
  config(
    materialized='table'
  )
}}

WITH stg_users AS (
  SELECT * FROM {{ref ('stg_users')}}
),

fact_products AS (
  SELECT
    user_id,
    MIN(created_at) AS user_first_order,
    MAX(created_at) AS user_last_order,
    COALESCE(COUNT(DISTINCT order_id), 0) AS order_count,
    COALESCE(COUNT(DISTINCT product_id), 0) AS products_ordered,
    COALESCE(SUM(order_quantity), 0) AS order_quantity,
    COALESCE(SUM(order_amount), 0) order_amount

  FROM {{ ref('fact_ordered_products') }}

  GROUP BY 1
),

int_user_sessions AS (
  SELECT  
    user_id,
    sum(checkout_total) AS checkout_total,
    sum(package_shipped_total) AS package_shipped_total,
    sum(add_to_cart_total) AS add_to_cart_total,
    sum(page_view_total) AS page_view_total

  FROM {{ ref('int_session_events') }}

  GROUP BY 1
)

SELECT 
  su.user_id,
  su.first_name,
  su.last_name,
  su.email,
  su.phone_number,
  fp.user_first_order,
  fp.user_last_order,
  fp.order_count,
  fp.products_ordered,
  fp.order_quantity,
  fp.order_amount,
  isu.page_view_total,
  isu.add_to_cart_total,
  isu.checkout_total,
  isu.package_shipped_total

FROM stg_users su
LEFT JOIN fact_products fp ON su.user_id = fp.user_id
LEFT JOIN int_user_sessions isu ON isu.user_id = su.user_id