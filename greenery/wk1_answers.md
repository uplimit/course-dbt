**1. How many users do we have?**

> There are currently distinct 130 users in the database as of today (Friday, April 24, 2023)

```
SELECT
    COUNT(DISTINCT user_id)
FROM
    dev_db.dbt_victoriaplum13gmailcom.stg_postgres_users
```

**2. On average, how many orders do we receive per hour?**

On average, we recieve 7.5 orders an hour (rounded)

```
WITH order_truncate AS
(
    SELECT
        DATE_TRUNC('HOUR',stg_po.created_at) as created_at_hour
        , COUNT(DISTINCT stg_po.order_id) as distinct_order_id_count
    FROM
        dev_db.dbt_victoriaplum13gmailcom.stg_postgres_orders stg_po
    GROUP BY created_at_hour
    ORDER BY created_at_hour
)

SELECT
    SUM(ot.distinct_order_id_count)/COUNT(ot.created_at_hour)::FLOAT as average_orders_per_hour
FROM
    order_truncate ot
```

**3. On average, how long does an order take from being placed to being delivered?**

On average, an order takes about ~3.89 days from being placed to being delivered (~93.4 hours if that type of granularity is needed)

```
WITH completed_orders AS
(
    SELECT
        stg_po.order_id
        , stg_po.created_at
        , stg_po.delivered_at
    FROM
        dev_db.dbt_victoriaplum13gmailcom.stg_postgres_orders stg_po
    WHERE stg_po.delivered_at IS NOT NULL
)

, order_times AS
(
    SELECT 
        co.order_id
        , TIMESTAMPDIFF(day,co.created_at,co.delivered_at) AS time_difference_day
        , TIMESTAMPDIFF(hour,co.created_at,co.delivered_at) AS time_difference_hour

    FROM completed_orders co
)

SELECT 
    SUM(ot.time_difference_day)/COUNT(ot.order_id)::float AS average_order_time_day
    , SUM(ot.time_difference_hour)/COUNT(ot.order_id)::float AS average_order_time_hour
FROM order_times ot
```

**4. How many users have only made one purchase? Two purchases? Three+ purchases? Note: you should consider a purchase to be a single order. In other words, if a user places one order for 3 products, they are considered to have made 1 purchase.**

We count the following:
    25 disctinct users have made 1 order 
    28 distinct users have made 2 orders,
    34 disctinct users have made 3 orders,
    20 dustinct users have made 4 orders,
    10 distinct users have made 5 orders,
    2 distinct users have made 6 orders,
    4 distinct users have made 7 orders
    and 1 distinct user has made 8 orders.

```
WITH user_order_counts AS
(
SELECT
    stg_po.user_id
    , COUNT(DISTINCT stg_po.order_id) as order_count
FROM 
    dev_db.dbt_victoriaplum13gmailcom.stg_postgres_orders stg_po
GROUP BY user_id
)

SELECT
    uoc.order_count
    , COUNT(uoc.user_id)
FROM user_order_counts uoc
GROUP BY uoc.order_count
ORDER BY uoc.order_count ASC


5. On average, how many unique sessions do we have per hour?

On average, we have 16.32 unique sessions per hour.

```
WITH session_truncate AS
(
    SELECT
        DATE_TRUNC('HOUR',created_at) as created_at_hour
        , COUNT(DISTINCT session_id) as distinct_session_id_count
    FROM
        dev_db.dbt_victoriaplum13gmailcom.stg_postgres_events
    GROUP BY created_at_hour
    ORDER BY created_at_hour
)

SELECT
    SUM(st.distinct_session_id_count)/COUNT(st.created_at_hour)::FLOAT
FROM
    session_truncate st
```




    