USE SCHEMA dev_db.dbt_jmanahan;

-- Number of users?
-- We have 130 users in our system.
SELECT
    COUNT(1) n
    , COUNT(DISTINCT u.user_id) n_users
FROM stg_user u
;


-- Average number of orders per hour?
-- Across the time period we've been making sales, we have about 7.7 orders in an average hour
-- Theoretically includes zero-order hours, although none of those have happened yet
SELECT
    ABS(TIMESTAMPDIFF(HOUR, MAX(o.order_created_at), MIN(o.order_created_at))) n_hours
    , COUNT(1) n_orders
    , n_orders / n_hours AS orders_per_hour
FROM stg_order o
;

-- Every hour has 1+ orders
SELECT
    DATE_TRUNC(HOUR, o.order_created_at) order_hour
    , COUNT(1) n_orders
FROM stg_order o
GROUP BY 1
HAVING n_orders = 0
;


-- Average time placed-to-delivered of an order?
-- 3.89 days for landed orders, 3.81 days if including estimates for unlanded orders where available
SELECT
    AVG(TIMESTAMPDIFF(SECOND, o.order_created_at, o.actual_delivered_at)) / 86400 AS days_to_deliver_actual
    , AVG(
        TIMESTAMPDIFF(
            SECOND
            , o.order_created_at
            , NVL(o.actual_delivered_at, o.estimated_delivered_at)
        )
      ) / 86400
      AS days_to_deliver_best_guess
FROM stg_order o
;


-- How many users have 1, 2, 3+ orders?
-- 25 users have one order, 28 have 2, and 71 have more
WITH cte_order_count AS (
    SELECT
        o.user_id
        , COUNT(1) n_orders
    FROM stg_order o
    GROUP BY 1
)
SELECT
    CASE WHEN oc.n_orders >= 3 THEN '3+' ELSE oc.n_orders::VARCHAR END AS n_orders
    , COUNT(1) n_users
FROM cte_order_count oc
GROUP BY 1
ORDER BY n_orders ASC
;


-- Average unique sessions per hour?
-- Across the time period we've been recording events, we have about 10.1 events in an average hour
-- Theoretically includes zero-session hours, although none of those have happened yet
SELECT
    ABS(TIMESTAMPDIFF(HOUR, MAX(e.event_created_at), MIN(e.event_created_at))) n_hours
    , COUNT(DISTINCT e.session_id) n_sessions
    , n_sessions / n_hours AS orders_per_hour
FROM stg_event e
;

-- Every hour has 1+ sessions
SELECT
    DATE_TRUNC(HOUR, e.event_created_at) event_hour
    , COUNT(DISTINCT e.session_id) n_sessions
FROM stg_event e
GROUP BY 1
HAVING n_sessions = 0
;