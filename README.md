# Analytics engineering with dbt

Template repository for the projects and environment of the course: Analytics engineering with dbt

> Please note that this sets some environment variables so if you create some new terminals please load them again.

## License

Apache 2.0

## Week 1 Questions

*1. How many users do we have?*

 **130**

Query:
```ruby
SELECT COUNT(DISTINCT user_id) FROM dbt_zoe_l.stg_users
```


*2. On average, how many orders do we receive per hour?*

**7.5**

Query:
```ruby
SELECT ROUND(AVG(number_of_orders), 1)
FROM
(SELECT DATE_TRUNC('hour', created_at_utc) AS created_hour, 
COUNT(DISTINCT order_id) AS number_of_orders 
FROM dbt_zoe_l.stg_orders
GROUP BY created_hour) a
```


*3. On average, how long does an order take from being placed to being delivered?*

**3.9 Days**

Query:
```ruby
SELECT ROUND(AVG(delivery_days), 1)
FROM
(SELECT CAST(delivered_at_utc AS DATE) - CAST(created_at_utc AS DATE) AS delivery_days
FROM dbt_zoe_l.stg_orders) b
```


*4. How many users have only made one purchase? Two purchases? Three+ purchases?*

| Number of Purchases | Number of Users |
| :---         |     :---:      |
| 1  | 25    | 
| 2    | 28      | 
| 3+     | 71      | 

Query:
```ruby
SELECT 
CASE  
WHEN number_of_orders >= 3 THEN '3+'
ELSE number_of_orders::VARCHAR END AS number_of_purchases,
COUNT(DISTINCT user_id) AS number_of_users
FROM
(SELECT user_id, count(distinct order_id) AS number_of_orders
FROM dbt_zoe_l.stg_orders
GROUP BY user_id) c
GROUP BY number_of_purchases
```


*5. On average, how many unique sessions do we have per hour?*

**16.3**

Query:
```ruby
SELECT ROUND(AVG(number_of_sessions), 1)
FROM
(SELECT DATE_TRUNC('hour', created_at_utc) AS created_hour, 
COUNT(DISTINCT session_id) AS number_of_sessions
FROM dbt_zoe_l.stg_events
GROUP BY created_hour) d
```
