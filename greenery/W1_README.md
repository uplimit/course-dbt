
---
**Week 1 Project**
1. **How many users do we have?**
- We have 130 users.
- Method: Use tables stg_greenery__users
1. Calculate the distinct number of users on the platform.

```sql
SELECT 
  COUNT(DISTINCT(user_id)) 
FROM dbt_jimmy_l.stg_greenery__users;
```
2. **On average, how many orders do we receive per hour?**
- On average, we receive about 7.52 orders per hour.
- Method: Use table stg_orders
1. Calculate the total orders per hour. 
2. Then, take the average of the total orders per hour.
```sql
WITH hourly_orders AS (
  SELECT 
    COUNT(order_id) as order_per_hour, 
    date_trunc('hour', created_at_utc) as utc_trunc
  FROM dbt_jimmy_l.stg_greenery__orders
  GROUP BY utc_trunc)

SELECT 
  AVG(order_per_hour)
FROM hourly_orders;
```

3. **On average, how long does an order take from being placed to being delivered?**

- Method: Use tables stg_orders
1. Calcuate the time it takes between order placed and order delivered. This is the delivery time.
2. Calculate the average of the delivery times.
```sql
WITH delivery_times AS (
  SELECT (
    delivered_at_utc - created_at_utc) AS order_delivery_time 
  FROM dbt_jimmy_l.stg_greenery__orders
  WHERE status = 'delivered'
)

SELECT 
  AVG(order_delivery_time)
FROM delivery_times;
```
- On average, it takes 3 days 21:24:11.803279
4. **How many users have only made one purchase? Two purchases? Three+ purchases?**
- 1 purchase: 25 users
- 2 purchase: 28 users
- 3 purchase: 71 users
- Method: Use table stg_orders
1. Count the number of times a user_id appears in orders
2. Then count the number of users who ordered 1, 2, or 3+ times.
```sql
WITH number_of_user_orders AS( 
SELECT 
  CASE 
    WHEN COUNT(user_id) = 1 THEN '1 order'
    WHEN COUNT(user_id) = 2 THEN '2 orders'
    WHEN COUNT(user_id) >= 3 THEN '3 or more orders' END AS num_orders
FROM dbt_jimmy_l.stg_greenery__orders
GROUP BY user_id
)
SELECT 
  num_orders, 
  COUNT(num_orders) AS orders_per_category
FROM number_of_user_orders
GROUP BY num_orders
ORDER BY num_orders;
```

5. **On average, how many unique sessions do we have per hour?**
- There are about 16.3 unique sessions per hour, on average.
- Method: Use table stg_events
1. Calculate how many sessions there are per hour. 
2. Determine how many of those are unique. 
3. Get the average of those unique sessions
```sql
WITH hourly_sessions AS (
  SELECT 
    COUNT(DISTINCT(session_id)) AS sessions_per_hour, 
    date_trunc('hour', created_at_utc) as utc_trunc
  FROM dbt_jimmy_l.stg_greenery__events
  GROUP BY utc_trunc)
  
SELECT 
  AVG(sessions_per_hour) AS unique_sessions_per_hour
FROM hourly_sessions;
```

**Useful things I learned in this project**
- Working with UTC Time Format 
- Staging setup - In our staging environment we want to set up our data thinking about how we want to receive it.
  - This includes formatting, descriptive field names, and considering splitting out fields into subject groups.
- Pro-tip: Look at the columns, data type, and ordinal_position of a table
```sql
SELECT
  column_name
  , data_type
  , ordinal_position
FROM dbt.information_schema.columns
WHERE LOWER(table_name) = 'users'
ORDER BY 3;
```

- You can `GROUP BY` column position instead of column name
```sql
  SELECT 
    COUNT(order_id), 
    date_trunc('hour', created_at_utc) as utc_trunc
  FROM dbt_jimmy_l.stg_greenery__orders
  GROUP BY utc_trunc
```
Is the same as:
```sql
  SELECT 
    COUNT(order_id), 
    date_trunc('hour', created_at_utc) as utc_trunc
  FROM dbt_jimmy_l.stg_greenery__orders
  GROUP BY 2
```
---