## How many users do we have?
A: 130

### Query
```sql
SELECT
count(distinct user_id) as users 
FROM dev_db.dbt_taislaurindopereiraxebiacom.stg_users
```
## On average, how many orders do we receive per hour? 
A: 7.52

### Query
```sql
WITH orders_per_hour as
(SELECT
DATE_TRUNC('hour', created_at) AS hour, COUNT(distinct order_id) AS order_count
FROM dev_db.dbt_taislaurindopereiraxebiacom.stg_orders
GROUP BY 1) 

SELECT AVG(order_count) as avg_orders
FROM orders_per_hour
```

## On average, how long does an order take from being placed to being delivered?
A: 93.4 hours

### Query
```sql
SELECT AVG(DATEDIFF('HOUR', created_at, delivered_at)) as average_delivery_time
FROM dev_db.dbt_taislaurindopereiraxebiacom.stg_orders
WHERE delivered_at is not null
```


## How many users have only made one purchase? Two purchases? Three+ purchases?
A: one purchase - 25, two purchases - 28, three or more - 71.

### Query
```sql
WITH orders_per_user AS
(
    SELECT
        user_id, count(distinct order_id) as orders
    FROM
        dev_db.dbt_taislaurindopereiraxebiacom.stg_users
    JOIN dev_db.dbt_taislaurindopereiraxebiacom.stg_orders
    USING (user_id)
    GROUP BY 1
),
user_categories AS (
    SELECT
        CASE
            WHEN orders = 1 THEN 'one order'
            WHEN orders = 2 THEN 'two orders'
            ELSE 'three or more'
        END AS user_category,
        COUNT(user_id) AS user_count
    FROM orders_per_user
    GROUP BY user_category
)
SELECT *
FROM user_categories;
```

## On average, how many unique sessions do we have per hour?
A: 16

### Query
```sql
WITH sessions_per_hour as
(SELECT
DATE_TRUNC('hour', created_at) AS hour, COUNT(distinct session_id) AS session_count
FROM dev_db.dbt_taislaurindopereiraxebiacom.stg_events
GROUP BY 1) 

SELECT AVG(session_count) as avg_sessions
FROM sessions_per_hour
```
