{{ config(
    materialized = "view"
) }} -- Fails tests if materialized as ephemeral

SELECT
    o.order_id
    , SUM(NVL(pm.discount_percentage, 0)) total_promo_discount_percentage
FROM {{ ref ('stg_order') }} o
LEFT JOIN {{ ref ('stg_promo') }} pm
    ON o.promo_id = pm.promo_id
GROUP BY 1