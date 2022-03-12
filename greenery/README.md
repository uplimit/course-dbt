Welcome to your new dbt project!

### Using the starter project

Try running the following commands:
- dbt run
- dbt test


### Resources:
- Learn more about dbt [in the docs](https://docs.getdbt.com/docs/introduction)
- Check out [Discourse](https://discourse.getdbt.com/) for commonly asked questions and answers
- Join the [chat](https://community.getdbt.com/) on Slack for live discussions and support
- Find [dbt events](https://events.getdbt.com) near you
- Check out [the blog](https://blog.getdbt.com/) for the latest 


--How many users do we have?
-- 130 unique users
~~~~sql
SELECT
    COUNT(DISTINCT user_id)
FROM stg_users;
~~~

--On average, how many orders do we receive per hour?
-- 7.52 orders per hour
~~~~sql
WITH orders_count AS (
  SELECT
    DATE_TRUNC('HOUR', created_at) AS hour,
    COUNT(order_id) AS count_orders
  FROM dbt_sydney_b.stg_orders
  GROUP BY 1
)
SELECT
  ROUND(AVG(count_orders),2) AS avg_orders_per_hour
FROM orders_count;
~~~
--On average, how long does an order take from being placed to being delivered?
-- 3 days, 21 hours and 24 minutes
~~~~sql
WITH time_to_order_fulfillment AS(
SELECT
  order_id,
  created_at,
  delivered_at,
  AGE(delivered_at, created_at) AS time_until_fulfillment
FROM dbt_sydney_b.stg_orders
)
SELECT
AVG(time_until_fulfillment)
FROM time_to_order_fulfillment;
~~~
--How many users have only made one purchase? Two purchases? Three+ purchases?
-- 1 order | 2 orders | 3+ orders 
    25     |    28    |   71
~~~~sql
WITH user_count AS(
SELECT
  user_id,
  COUNT(*) AS orders_count
FROM dbt_sydney_b.stg_orders
GROUP BY 1
)
SELECT
  CASE
    WHEN orders_count = 1 THEN '1'
    WHEN orders_count = 2 THEN '2'
    WHEN orders_Count >= 3 THEN '3'
    ELSE null
  END AS orders_placed_count,
  count(*)
  FROM user_count
  GROUP BY 1;
~~~
--On average, how many unique sessions do we have per hour?
-- 16 unique sessions per hour
~~~~sql
WITH session_counts AS(
SELECT
  DATE_TRUNC('hour',created_at) AS hour,
  COUNT(DISTINCT session_id) AS sessions_per_hour
FROM dbt_sydney_b.stg_events
GROUP BY 1
)
SELECT
avg(sessions_per_hour) AS average_unique_sessions_per_hour
FROM session_counts;
~~~