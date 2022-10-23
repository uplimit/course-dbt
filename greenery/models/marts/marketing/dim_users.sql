{{
  config(
    materialized='table'
  )
}}

WITH int_users AS (
    SELECT *
    FROM {{ ref('int_users_addresses') }}
),

int_orders AS (
    SELECT 
    user_id,
    MIN(created_at) AS user_first_order,
    MAX(created_at) AS user_last_order,
    COALESCE(COUNT(DISTINCT order_id), 0) AS order_count

    FROM {{ ref('int_orders') }}

    GROUP BY 1
),

int_products AS (
    SELECT
    user_id,
    COALESCE(COUNT(DISTINCT product_id), 0) AS products_ordered,
    COALESCE(SUM(order_quantity), 0) AS order_quantity,
    COALESCE(SUM(order_amount), 0) order_amount

    FROM {{ ref('int_ordered_products') }}

    GROUP BY 1
),

user_session_count AS (
    SELECT
    user_id,
    count(DISTINCT session_id) as total_session_count

    FROM {{ ref('stg_events') }} 

    GROUP BY 1
),

int_user_sessions AS (
  SELECT *
  FROM {{ ref('int_session_events') }}
)

SELECT
iu.user_id,
iu.first_name,
iu.last_name,
iu.email,
iu.phone_number,
io.user_first_order,
io.user_last_order,
io.order_count,
ip.products_ordered,
ip.order_quantity,
ip.order_amount,
ise.page_view_total,
ise.add_to_cart_total,
ise.checkout_total,
ise.package_shipped_total,
ise.has_converted,
usc.total_session_count

FROM int_users iu
LEFT JOIN int_orders io
ON iu.user_id = io.user_id
LEFT JOIN int_products ip
ON ip.user_id = io.user_id
LEFT JOIN int_session_events ise
ON iu.user_id = ise.user_id
LEFT JOIN user_session_count usc
ON iu.user_id = usc.user_id
