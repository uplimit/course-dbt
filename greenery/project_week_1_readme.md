### Project - Week 1  

** How many users do we have? **
We have 130 users  
'''
SELECT COUNT(DISTINCT user_guid) 
FROM dev_db.dbt_danagrunberggmailcom.stg_postgres_users  
'''

** On average, how many orders do we receive per hour? **  
We recieve 7.52 orders per hour  

''' 
WITH hourly_orders_count AS (
SELECT DATE_TRUNC('hour', created_at_utc)
      , COUNT(DISTINCT order_guid) AS hourly_orders_count
FROM dev_db.dbt_danagrunberggmailcom.stg_postgres_orders
GROUP BY 1
)

SELECT ROUND(AVG(hourly_orders_count), 2)
FROM hourly_orders_count 
'''  

** On average, how long does an order take from being placed to being delivered? **  
3.89 days
'''
WITH order_and_delivery_timediff AS (
SELECT  order_guid, DATEDIFF(dd, created_at_utc, delivered_at_utc) days_between_order_and_delivery, *
FROM dev_db.dbt_danagrunberggmailcom.stg_postgres_orders
WHERE delivered_at_utc is not null
)

SELECT ROUND(AVG(days_between_order_and_delivery),2)
FROM order_and_delivery_timediff
'''

** How many users have only made one purchase? Two purchases? Three+ purchases? **  
* 25 users made 1 purchase  
* 28 users made 2 purchases  
* 71 users made more than 3 purchases
'''
WITH orders_count_per_users AS (
SELECT  user_guid, COUNT(DISTINCT order_guid) AS purchase_count
FROM dev_db.dbt_danagrunberggmailcom.stg_postgres_orders
GROUP BY 1
)
, number_of_users_purchasing_count AS (
SELECT purchase_count, COUNT(DISTINCT user_guid) AS number_of_users_with_this_amount_of_purchases
FROM orders_count_per_users
GROUP BY 1
ORDER BY 1 ASC
)

SELECT CASE WHEN purchase_count = 1 THEN '1'
            WHEN purchase_count = 2 THEN '2'
            WHEN purchase_count >= 3 THEN '3+' END AS purchase_case 
    , SUM(number_of_users_with_this_amount_of_purchases)
FROM number_of_users_purchasing_count
GROUP BY 1

'''
** On average, how many unique sessions do we have per hour? **  
16.33
'''
WITH hourly_session_count AS (
SELECT DATE_TRUNC('hour', created_at_utc)
      , COUNT(DISTINCT session_guid) AS hourly_session_count
FROM dev_db.dbt_danagrunberggmailcom.stg_postgres_events
GROUP BY 1
)

SELECT ROUND(AVG(hourly_session_count), 2)
FROM hourly_session_count 
'''