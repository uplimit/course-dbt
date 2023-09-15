WITH 
	--1. How many users do we have?
	qtt_users AS (
		SELECT
			COUNT(DISTINCT user_id) AS distinct_users
		FROM {{ ref("stg_users") }}
	)--qtt_users



	--2. On average, how many orders do we receive per hour?
	, orders_per_hour AS (
		SELECT
			date_trunc('HOUR', created_at) AS hour
			, COUNT(DISTINCT order_id) 	   AS order_count
		FROM {{ ref("stg_orders") }}
		GROUP BY date_trunc('HOUR', created_at)
	)--orders_per_hour


	, avg_orders_per_hour AS (
		SELECT
			AVG(order_count) 	   AS avg_order_per_hour
		FROM orders_per_hour
	)--avg_orders_per_hour


	--3. On average, how long does an order take from being placed to being delivered?
	, avg_delivery_time AS (
        SELECT 
			AVG(DATEDIFF(hour, created_at, delivered_at)) AS avg_hours_to_deliver
        FROM {{ ref("stg_orders") }}
        WHERE delivered_at IS NOT NULL
	)--avg_delivery_time



	-- 4. How many users have only made one purchase? Two purchases? Three+ purchases?
    , purchases_by_user AS (
        SELECT 
			user_id
			, COUNT(DISTINCT order_id) AS total_purchases
        FROM {{ ref("stg_orders") }}
        GROUP BY user_id
    )--purchases_by_user  

	, purchase_counter AS (
        SELECT
            SUM(CASE WHEN total_purchases = 1 THEN 1 ELSE 0 end)  AS users_with_one_purchase
            , SUM(CASE WHEN total_purchases = 2 THEN 1 ELSE 0 end)  AS users_with_two_purchase
            , SUM(CASE WHEN total_purchases >= 3 THEN 1 ELSE 0 end) AS users_with_three_purchase
        FROM purchases_by_user
    )--purchase_counter



    -- 5. On average, how many unique sessions do we have per hour?
    ,sessions_per_hour AS (
        SELECT
            DATE_TRUNC('HOUR', created_at) AS session_hour
            , COUNT(DISTINCT session_id)     AS session_count
        FROM {{ ref("stg_events") }}
        GROUP BY DATE_TRUNC('HOUR', created_at) 
    )

    avg_sessions_per_hour AS (
        SELECT 
			AVG(session_count) AS avg_session_per_hour 
		FROM sessions_per_hour
    )



SELECT
	qtt_users.distinct_users
	, avg_orders_per_hour.avg_order_per_hour 
	, avg_delivery_time.avg_hours_to_deliver
	, purchase_counter.users_with_one_purchase
	, purchase_counter.users_with_two_purchase
	, purchase_counter.users_with_three_purchase
	, avg_sessions_per_hour.avg_session_per_hour
FROM qtt_users
CROSS JOIN 
	avg_orders_per_hour
CROSS JOIN
	avg_delivery_time
CROSS JOIN
	purchase_counter
CROSS JOIN
	avg_sessions_per_hour