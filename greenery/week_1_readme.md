```sql
-- How many users do we have?
-- > 130
select count(user_guid) from stg_postgres__users

-- On average, how many orders do we receive per hour?
-- > 7.680851
SELECT 
    COUNT(*) / DATEDIFF(hour, MIN(created_at), MAX(created_at)) AS average_orders_per_hour
FROM 
    stg_postgres__orders;

-- On average, how long does an order take from being placed to being delivered?
-- > 93.403279
SELECT 
    AVG(DATEDIFF(hour, created_at, delivered_at)) AS average_delivery_time_hour
FROM 
    stg_postgres__orders
WHERE 
    delivered_at IS NOT NULL;

-- How many users have only made one purchase? Two purchases? Three+ purchases?
-- Note: you should consider a purchase to be a single order. In other words, if a user places one order for 3 products, they are considered to have made 1 purchase.
-- NUM_PURCHASES	NUM_USERS
-- 1	            25
-- 2	            28
-- 3+	            71
SELECT
    num_purchases,
    COUNT(DISTINCT user_id) AS num_users
FROM (
    SELECT
        user_id,
        COUNT(distinct order_id) AS num_purchases
    FROM
        stg_postgres__orders
    GROUP BY
        user_id
) AS purchase_counts
GROUP BY
    num_purchases
ORDER BY
    num_purchases;


-- On average, how many unique sessions do we have per hour?
-- > 16.327586
SELECT 
    AVG(unique_sessions_per_hour) AS average_unique_sessions_per_hour
FROM (
    SELECT 
        DATE_TRUNC('hour', created_at) AS hour_start,
        COUNT(DISTINCT session_id) AS unique_sessions_per_hour
    FROM 
        stg_postgres__events
    GROUP BY 
        hour_start
) AS hourly_session_counts;
```