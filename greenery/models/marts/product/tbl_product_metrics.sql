{{ config(materialized = "table") }}

WITH cte_product_event AS (
    SELECT
        e.product_id
        , COUNT(DISTINCT e.session_id) product_session_count
        , COUNT(IFF(e.event_type = 'page_view', 1, NULL)) product_page_view_count
        , COUNT(IFF(e.event_type = 'add_to_cart', 1, NULL)) product_add_to_cart_count
    FROM {{ ref ('stg_event') }}  e
    WHERE product_id IS NOT NULL
    GROUP BY 1
)

SELECT
    pr.product_id
    , pr.product_name
    , pr.inventory AS current_inventory
    , pr.price AS current_price
    , SUM(oi.quantity) quantity_ordered
    , ROUND(
        SUM({{
            order_revenue(
                price_col = 'current_price'
                , quantity_col = 'oi.quantity'
                , discount_col = 'od.total_promo_discount_percentage'
            )
        }})
        , 2
      ) total_order_revenue
    -- Product cost is missing, but could be guessed from stg_order.order_cost
    , COUNT(1) product_order_count
    , COUNT(DISTINCT o.user_id) product_user_count
    , NVL(pe.product_session_count, 0) product_session_count
    , NVL(pe.product_page_view_count, 0) product_page_view_count
    , NVL(pe.product_add_to_cart_count, 0) product_add_to_cart_count
    , ROUND(
        product_add_to_cart_count / NULLIF(product_page_view_count, 0)
        , 4
      ) product_click_through_rate
FROM {{ ref ('stg_product') }}  pr
JOIN {{ ref ('stg_order_item') }}  oi
    ON pr.product_id = oi.product_id
JOIN {{ ref ('stg_order') }}  o
    ON oi.order_id = o.order_id
LEFT JOIN {{ ref ('int_order_discount') }}  od
    ON o.order_id = od.order_id
JOIN {{ ref ('tbl_order_ledger') }}  ol
    ON oi.order_id = ol.order_id
LEFT JOIN cte_product_event pe
    ON pr.product_id = pe.product_id
GROUP BY 1,2,3,4
    , pe.product_session_count
    , pe.product_page_view_count
    , pe.product_add_to_cart_count