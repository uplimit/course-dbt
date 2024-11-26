{{ config(
    materialized = "table"
) }}

-- Aggregate base price to promo granularity
WITH cte_promo_order_item AS (
    SELECT o.promo_id
        , SUM(oi.quantity * pr.price) base_price -- TODO: should be price at time of order
    FROM {{ ref ('stg_order_item') }} oi
    JOIN {{ ref ('stg_order') }}  o
        ON oi.order_id = o.order_id
    JOIN {{ ref ('stg_product') }}  pr
        ON oi.product_id = pr.product_id
    GROUP BY o.promo_id
)

SELECT
    pm.promo_id
    , pm.promo_name
    , pm.discount_percentage
    , pm.promo_status
    , MIN(o.order_created_at) promo_first_used_at
    , MAX(o.order_created_at) promo_last_used_at
    , COUNT(o.order_id) promo_order_count
    , COUNT(DISTINCT o.user_id) promo_user_count
    , SUM(NVL(poi.base_price, 0)) * pm.discount_percentage AS promo_cost
FROM {{ ref ('stg_promo') }}  pm
LEFT JOIN {{ ref ('stg_order') }}  o
    ON pm.promo_id = o.promo_id
LEFT JOIN cte_promo_order_item poi
    ON pm.promo_id = poi.promo_id
GROUP BY 1,2,3,4