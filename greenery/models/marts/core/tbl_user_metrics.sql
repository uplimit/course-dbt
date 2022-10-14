{{ config(
    materialized = "table"
) }}

WITH cte_user_session AS (
    SELECT
        sm.user_id
        , COUNT(DISTINCT sm.session_id) user_session_count
        , MIN(sm.session_start_tstamp) user_first_activity
        , MAX(sm.session_end_tstamp) user_last_activity
        , SUM(sm.session_length_minutes) user_minutes_active
        , SUM(sm.page_view_count) user_page_view_count
        , SUM(sm.add_to_cart_count) user_add_to_cart_count
        , SUM(sm.checkout_count) user_checkout_count
        , SUM(sm.package_shipped_event_count) user_package_shipped_event_count
    FROM {{ ref ('tbl_session_metrics') }} sm
    GROUP BY sm.user_id
)

, cte_user_order_financial AS (
    SELECT
        o.user_id    
        , COUNT(1) user_order_count
        , COUNT(IFF(ol.total_promo_discount_percentage > 0, 1, NULL)) user_order_with_promo_count
        , AVG(ol.total_promo_discount_percentage) user_average_order_promo_discount_percentage
        , SUM(ol.order_cost) user_order_cost
        , SUM(ol.shipping_cost) user_shipping_cost
        , SUM(ol.total_order_cost) user_total_order_cost
        , SUM(ol.total_order_revenue) user_total_order_revenue
        , SUM(ol.total_order_profit) user_total_order_profit
    FROM {{ ref ('tbl_order_ledger') }} ol
    JOIN {{ ref ('stg_order') }} o
        ON ol.order_id = o.order_id
    GROUP BY o.user_id
)

, cte_user_order_logistics AS (
    SELECT
        o.user_id
        , COUNT(IFF(shm.order_status = 'delivered', 1, NULL)) user_delivered_order_count
        , COUNT(IFF(shm.order_status IN ('delivered', 'shipped'), 1, NULL)) user_shipped_order_count
        , AVG(shm.hours_to_ship) user_avg_hours_to_ship
        , AVG(shm.hours_to_arrive) user_avg_hours_to_arrive
        , MIN(o.order_created_at) first_user_order_at
        , MAX(o.order_created_at) last_user_order_at
    FROM {{ ref ('tbl_shipping_metrics') }} shm
    JOIN {{ ref ('stg_order') }} o
        ON shm.order_id = o.order_id
    GROUP BY o.user_id
)

SELECT
    u.user_id
    
    -- Identity information
    , u.first_name
    , u.last_name
    , u.email
    , u.phone_number
    , addr.street_address
    , addr.zip_code
    , addr.state_name
    , addr.country_name
    
    -- Engagement metrics
    , us.user_session_count
    , uol.first_user_order_at
    , uol.last_user_order_at
    , us.user_first_activity
    , us.user_last_activity
    , us.user_minutes_active
    , us.user_page_view_count
    , us.user_add_to_cart_count
    , us.user_checkout_count
    , us.user_package_shipped_event_count
    , uol.user_shipped_order_count
    , uol.user_delivered_order_count
    
    -- Finanancial metrics
    , uof.user_order_count
    , uof.user_order_with_promo_count
    , uof.user_average_order_promo_discount_percentage
    , uof.user_order_cost
    , uof.user_shipping_cost
    , uof.user_total_order_cost
    , uof.user_total_order_revenue
    , uof.user_total_order_profit
    , ROUND(
        uof.user_total_order_profit / uof.user_total_order_revenue
        , 4
      ) AS user_order_margin_pct
    
    -- Logistics metrics
    , uol.user_avg_hours_to_ship
    , uol.user_avg_hours_to_arrive
    
    -- Processing information
    , u.user_created_at
    , u.user_updated_at
FROM {{ ref ('stg_user') }} u
LEFT JOIN cte_user_session us
    ON u.user_id = us.user_id
LEFT JOIN {{ ref ('stg_address') }} addr
    ON u.address_id = addr.address_id
LEFT JOIN cte_user_order_financial uof
    ON u.user_id = uof.user_id
LEFT JOIN cte_user_order_logistics uol
    ON u.user_id = uol.user_id