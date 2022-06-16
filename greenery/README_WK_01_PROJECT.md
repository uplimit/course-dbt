**WEEK 01 HOMEWORK QUESTIONS**

1. How many users do we have? **130 users**
```sql
select count(distinct user_id) from dbt_jason_d.stg_public__users;
```


2. On average, how many orders do we receive per hour? **Average of 7.5 Orders per Hour**

```sql
with order_count_by_hour as (

    -- create grouping variable 'day_hour' and get order count by hour
    select 
        concat(date_part('day', created_at), '-', date_part('hour', created_at)) as day_hour,
        count(distinct order_id) as order_count
    from dbt_jason_d.stg_public__orders
    group by day_hour

),

aggregated_totals as (

    -- summarize to get aggregated totals
    select 
        sum(order_count) as total_orders, 
        count(day_hour) as total_hours 
    from order_count_by_hour
)

-- calculate summary statistic(s)
select 
    round((total_orders / total_hours),1) as avg_orders_per_hour 
from aggregated_totals;
```


3. On average, how long does an order take from being placed to being delivered? **Avg. Delivery time of 3 Days, 21 Hrs, 24 Mins.**

```sql
with time_to_delivery_per_order as (

    -- get time (days) to delivery for orders delivered
    select 
        delivered_at, created_at, 
        delivered_at - created_at as time_to_delivery

    from dbt_jason_d.stg_public__orders
    where status = 'delivered'
)

-- calculate summary statistic(s)
select 
    avg(time_to_delivery) as avg_delivery_time 
from time_to_delivery_per_order
```

4. How many users have only made one purchase? Two purchases? Three+ purchases?
    - **Note:** you should consider a purchase to be a single order. In other words, if a user places one order for 3 products, they are considered to have made 1 purchase.
        - One Purchase: **25**
        - Two Purchases: **28**
        - Three+ Purchases: **71**

```sql
with user_purchase_frequency as (

    -- classify user purchase frequency
    select 
        user_id, 
        case when count(distinct order_id) = 1 then 'One'
             when count(distinct order_id) = 2 then 'Two'
             else 'Three+'
        end as purchases
    from dbt_jason_d.stg_public__orders
    group by 1
  )
  
-- calculate summary statistic(s)
select
    purchases,
    count(purchases) as user_count
from user_purchase_frequency
group by 1
```


5. On average, how many unique sessions do we have per hour? **Avg. of 11.8 Unique Sessions per Hour**

```sql
with distinct_sessions as (

    -- get first session_id for each session (AVOIDS DOUBLE COUNTING SESSIONS THAT BLEED INTO NEXT HOUR) 🔑 
    select 
        session_id, 
        min(date_trunc('hour', created_at_utc)) as session_hour 
    from dbt_jason_d.stg_public__events 
    group by 1
  
),

distinct_session_count_by_hour as (

    -- count hourly sessions
    select 
        session_hour, 
        count(distinct session_id) as session_count 
    from distinct_sessions group by 1
)

-- calculate summary statistic(s)
select round(avg(session_count),1) as avg_sessions_per_hour
from distinct_session_count_by_hour
```
