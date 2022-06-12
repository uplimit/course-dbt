# Project 1
## How many users do we have?
 
```select count(distinct user_id) from dbt_ross_d.stg_greenery__users;```

Answer: 130


## On average, how many orders do we receive per hour?

```
with hourly_orders as 
(
  select 
    count(distinct order_id) as order_count, 
    date_trunc('hour', created_at) order_date_hour
  from dbt_ross_d.stg_greenery__orders
  group by order_date_hour
)
select avg(order_count) as avg_hourly_order_count from hourly_orders
```

Answer: 7.5208333333333333


## On average, how long does an order take from being placed to being delivered?
```
with delivered_orders as
(
  select order_id, created_at, delivered_at
  from dbt_ross_d.stg_greenery__orders
  where delivered_at is not null and created_at is not null
    and delivered_at > created_at
),
delivery_times as
(
  select 
    delivered_at - created_at as delivery_time
  from delivered_orders
  
)

select avg(delivery_time) as average_delivery_time from delivery_times
```

Answer: 3 days 21:24:11.803279


## How many users have only made one purchase? Two purchases? Three+ purchases?

```
with user_orders as
(
  select users.user_id, orders.order_id from dbt_ross_d.stg_greenery__users as users
  join dbt_ross_d.stg_greenery__orders as orders on orders.user_id = users.user_id
),
user_order_counts as
(
  select 
    count(distinct order_id) as order_count, 
    user_id from user_orders
  group by user_id
)

select 
  sum(case when order_count = 1 then 1 else 0 end) as order_count_1,
  sum(case when order_count = 2 then 1 else 0 end) as order_count_2,
  sum(case when order_count >= 3 then 1 else 0 end) as order_count_3_plus
from user_order_counts
```

Answer: 
1 order: 25
2 orders: 28
3+ orders: 71


## On average, how many unique sessions do we have per hour?

```
with hourly_sessions as 
(
  select 
    count(distinct session_id) as session_count, 
    date_trunc('hour', created_at) event_hour
  from dbt_ross_d.stg_greenery__events
  group by event_hour
)
select avg(session_count) as avg_hourly_session_count from hourly_sessions
```

Answer: 16.3275862068965517