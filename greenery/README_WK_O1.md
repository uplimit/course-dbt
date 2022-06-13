**WEEK 01 HOMEWORK QUESTIONS**

1. How many users do we have? **130 users**
```
select count(distinct user_id) from dbt_jason_d.stg_public__users;
```


2. On average, how many orders do we receive per hour? **Average of 7.5 Orders per Hour**

```
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


3. On average, how long does an order take from being placed to being delivered? **Average Delivery time of 3 Days, 21 Hours, 24 Minutes.**

```
with time_to_delivery_per_order as (

    -- get time to delivery for orders delivered
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

```
select 
```


5. On average, how many unique sessions do we have per hour?

```
select
```