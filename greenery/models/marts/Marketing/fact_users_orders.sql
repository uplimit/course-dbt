{{
  config(
    materialized='table'
  )
}}

SELECT 
    u.user_id
    , count(o.order_id) AS  count_orders
    , count(case when o.promo_id is not null then o.promo_id end) AS count_promo_orders
    , date(min(o.created_at)) AS first_order_date
    , date(max(o.created_at)) AS last_order_date
    , round(avg(o.order_total),2) AS avg_order_total
FROM {{ ref ('stg_postgres__users') }} u 
LEFT JOIN {{ ref ('stg_postgres__orders') }} o 
ON u.user_id = o.user_id
WHERE o.status = 'delivered'
group by all