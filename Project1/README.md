# Project 1

### How many users do we have?
130

```sql
SELECT COUNT(user_guid) FROM dev_db.dbt_danieloutschoolcom.stg_postgres__users;
```

### On average, how many orders do we receive per hour?
5.416668

```sql
WITH orders_received_hourly as (
SELECT date_trunc('hour', created_at) as hour_received
, COUNT(*) as num_received_this_hour
FROM dev_db.dbt_danieloutschoolcom.stg_postgres__orders
GROUP BY 1
)

SELECT AVG(num_received_this_hour) as average_num_orders_received_hourly
FROM orders_received_hourly;
```

### On average, how long does an order take from being placed to being delivered?

93.4

```sql
with delivery_hours as
(
    SELECT created_at
    , delivered_at
    , datediff(hour, created_at, delivered_at) as hours_to_deliver
    FROM dev_db.dbt_danieloutschoolcom.stg_postgres__orders
    WHERE status = 'delivered'
)

SELECT round(AVG(hours_to_deliver), 2)
FROM delivery_hours
;
```

### How many users have only made one purchase? Two purchases? Three+ purchases?
1 purchase = 25 users
2 purchases = 28 users
3 or more purchass = 71

```sql
WITH orders_per_user_table as (
    SELECT user_guid
    , COUNT(distinct order_guid) as orders_per_user
    FROM dev_db.dbt_danieloutschoolcom.stg_postgres__orders
    GROUP BY user_guid
)

SELECT orders_per_user
, COUNT(distinct user_guid) as users_with_this_many_orders
FROM orders_per_user_table
GROUP BY orders_per_user
;
```

```sql
WITH orders_per_user_table as (
    SELECT user_guid
    , COUNT(distinct order_guid) as orders_per_user
    FROM dev_db.dbt_danieloutschoolcom.stg_postgres__orders
    GROUP BY user_guid
),

user_order_counts as (
    SELECT orders_per_user
    , COUNT(distinct user_guid) as num_users_with_this_many_orders
    FROM orders_per_user_table
    GROUP BY orders_per_user
)

SELECT SUM(num_users_with_this_many_orders) as num_users_with_three_or_more_orders
FROM user_order_counts
WHERE orders_per_user >= 3
;
```

### Note: you should consider a purchase to be a single order. In other words, if a user places one order for 3 products, they are considered to have made 1 purchase.

### On average, how many unique sessions do we have per hour?

16.33

```sql
WITH unique_sessions_per_hour as (
    SELECT date_trunc(hour, created_at) as created_hour
    , COUNT(distinct session_guid) as sessions_per_hour
    FROM dev_db.dbt_danieloutschoolcom.stg_postgres__events
    GROUP BY created_hour
)

SELECT round(AVG(sessions_per_hour), 2)
FROM unique_sessions_per_hour
;
```
