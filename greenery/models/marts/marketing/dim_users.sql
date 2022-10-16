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
    SELECT *
    FROM {{ ref('int_orders') }}
),

int_products AS (
    SELECT *
    FROM {{ ref('int_ordered_products') }}
)

SELECT
iu.user_id,
iu.first_name,
iu.last_name,
iu.email,
iu.phone_number,
iu.created_at AS user_created_at,
MIN(io.created_at) AS user_first_order,
MAX(io.created_at) AS user_last_order,
COALESCE(COUNT(DISTINCT io.order_id), 0) AS order_count,
COALESCE(COUNT(DISTINCT ip.product_id), 0) AS products_ordered,
COALESCE(SUM(ip.order_quantity), 0) AS order_quantity,
COALESCE(SUM(ip.order_amount), 0) order_amount

FROM int_users iu
LEFT JOIN int_orders io
ON iu.user_id = io.user_id
LEFT JOIN int_products ip
ON ip.order_id = io.order_id

GROUP BY 1, 2, 3, 4, 5, 6