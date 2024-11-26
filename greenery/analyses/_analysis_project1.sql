--How many users do we have?
SELECT COUNT(DISTINCT USER_ID) FROM DEV_DB.DBT_COKERBUSAYO.STG_POSTGRES_USERS;

--On average, how many orders do we receive per hour?

WITH orders_per_hour AS (
    SELECT HOUR(CREATED_AT)
           ,COUNT(DISTINCT ORDER_ID) AS NUM_OF_ORDERS
    FROM DEV_DB.DBT_COKERBUSAYO.STG_POSTGRES_ORDERS
    GROUP BY HOUR(CREATED_AT)
)

SELECT AVG(NUM_OF_ORDERS)
FROM orders_per_hour;

--On average, how long does an order take from being placed to being delivered?
WITH orders_delivered AS (
    SELECT ORDER_ID
           ,CREATED_AT
           ,DELIVERED_AT
           ,TIMESTAMPDIFF('minutes', CREATED_AT, DELIVERED_AT) AS DELIVERY_TIME
    FROM DEV_DB.DBT_COKERBUSAYO.STG_POSTGRES_ORDERS
            WHERE DELIVERED_AT IS NOT NULL
)

SELECT ROUND((AVG(DELIVERY_TIME)/60),2)
FROM orders_delivered;

--How many users have only made one purchase? Two purchases? Three+ purchases?
WITH customer_purchases AS (
    SELECT USER_ID
           ,COUNT(DISTINCT ORDER_ID) AS NUM_ORDERS
    FROM DEV_DB.DBT_COKERBUSAYO.STG_POSTGRES_ORDERS
    GROUP BY USER_ID
)

SELECT SUM(CASE WHEN NUM_ORDERS = 1 THEN 1 ELSE 0 END) AS one
       ,SUM(CASE WHEN NUM_ORDERS = 2 THEN 1 ELSE 0 END) AS two
       ,SUM(CASE WHEN NUM_ORDERS >= 3 THEN 1 ELSE 0 END) AS three_or_more
FROM customer_purchases;

--On average, how many unique sessions do we have per hour?
WITH sessions_per_hour AS (
    SELECT HOUR(CREATED_AT) AS SESSION_HOUR
           ,COUNT(DISTINCT SESSION_ID) AS NUM_SESSIONS
    FROM DEV_DB.DBT_COKERBUSAYO.STG_POSTGRES_EVENTS
    GROUP BY HOUR(CREATED_AT)
)

SELECT AVG(NUM_SESSIONS)
FROM sessions_per_hour;

select distinct event_type from DEV_DB.DBT_COKERBUSAYO.STG_POSTGRES_EVENTS;