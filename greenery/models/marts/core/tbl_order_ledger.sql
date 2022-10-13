{{ config(
    materialized = "table"
) }}

SELECT
    o.order_id
    , o.order_created_at
    , o.order_status
    , od.total_promo_discount_percentage
    , o.order_cost
    , o.shipping_cost
    , o.total_order_cost
    , SUM(
        pr.price
        * oi.quantity
        * (1 - od.total_promo_discount_percentage)
      ) total_order_revenue
    , total_order_revenue - o.total_order_cost AS total_order_profit
    , total_order_profit / total_order_revenue AS order_margin_pct
FROM {{ ref ('stg_order') }} o
JOIN {{ ref ('int_order_discount') }} od
    ON o.order_id = od.order_id
JOIN {{ ref ('stg_order_item') }} oi
    ON o.order_id = oi.order_id
JOIN {{ ref ('stg_product') }} pr
    ON oi.product_id = pr.product_id
GROUP BY 1,2,3,4,5,6,7
