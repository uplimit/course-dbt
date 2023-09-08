How many users do we have? 130
    SELECT COUNT(DISTINCT USER_ID) AS user_count
    FROM DEV_DB.DBT_ANNBARD12.STG_USERS

On average, how many orders do we receive per hour? 7.68
    SELECT 
    COUNT(DISTINCT order_id) / TIMEDIFF(HOUR, MIN(created_at), MAX(created_at)) as orders_per_hour
    FROM DEV_DB.DBT_ANNBARD12.STG_ORDERS

On average, how long does an order take from being placed to being delivered? 3.89 days
    SELECT 
    AVG(TIMEDIFF(DAY, created_at, delivered_at)) AS avg_delivery_time
    FROM DEV_DB.DBT_ANNBARD12.STG_ORDERS


How many users have only made one purchase? Two purchases? Three+ purchases? 1 order: 25, 2 orders: 28, 3+ orders: 71

Note: you should consider a purchase to be a single order. In other words, if a user places one order for 3 products, they are considered to have made 1 purchase.

    WITH orders_per_user AS (
    SELECT 
    u.user_id,
    COUNT(DISTINCT o.order_id) AS order_count

    FROM DEV_DB.DBT_ANNBARD12.STG_USERS u
    JOIN DEV_DB.DBT_ANNBARD12.STG_ORDERS o
    ON u.user_id = o.user_id

    GROUP BY 1)

    SELECT
    CASE WHEN order_count = 1 THEN 'one_order'
     WHEN order_count = 2 THEN 'two_orders'
     WHEN order_count >= 3 THEN 'over_three_orders'
     ELSE NULL
     END 
    AS nr_orders_per_user,
    COUNT(DISTINCT user_id) nr_users
 
    FROM orders_per_user

    GROUP BY 1

On average, how many unique sessions do we have per hour? 10.1
    SELECT COUNT(DISTINCT session_id) / timediff(HOUR, MIN(CREATED_AT), MAX(CREATED_AT)) AS unique_sessions_per_hour
    FROM DEV_DB.DBT_ANNBARD12.STG_EVENTS