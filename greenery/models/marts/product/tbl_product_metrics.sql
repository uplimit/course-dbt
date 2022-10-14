{{ config(materialized = "table") }}

WITH cte_product_event AS (
    SELECT
        e.product_id
        , e.event_type
        , COUNT(1) product_event_count
    FROM {{ ref ('stg_event') }}  e
    WHERE product_id IS NOT NULL
    GROUP BY 1,2
)

SELECT
    pr.product_id
    , pr.product_name
    , pr.inventory AS current_inventory
    , pr.price AS current_price
    , SUM(oi.quantity) quantity_ordered
    , ROUND(SUM(
        current_price -- TODO: Price at time of order
        * oi.quantity
        * (1 - od.total_promo_discount_percentage)
      ), 2) total_product_revenue
    -- Product cost is missing, but could be guessed from stg_order.order_cost
    , COUNT(1) product_order_count
    , COUNT(DISTINCT o.user_id) product_user_count
    , SUM(pv.product_event_count) product_page_view_count -- SUM equivalent to unaggregated
    , SUM(atc.product_event_count) product_add_to_cart_count
    , ROUND(product_add_to_cart_count / product_page_view_count, 4) product_click_through_rate
FROM {{ ref ('stg_product') }}  pr
JOIN {{ ref ('stg_order_item') }}  oi
    ON pr.product_id = oi.product_id
JOIN {{ ref ('stg_order') }}  o
    ON oi.order_id = o.order_id
LEFT JOIN {{ ref ('int_order_discount') }}  od
    ON o.order_id = od.order_id
JOIN {{ ref ('tbl_order_ledger') }}  ol
    ON oi.order_id = ol.order_id
LEFT JOIN cte_product_event pv -- page_view
    ON pr.product_id = pv.product_id
    AND pv.event_type = 'page_view'
LEFT JOIN cte_product_event atc -- add_to_cart
    ON pr.product_id = atc.product_id
    AND atc.event_type = 'add_to_cart'
GROUP BY 1,2,3,4