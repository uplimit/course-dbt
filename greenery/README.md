### Greenery

## Week 1

1. How many users do we have?

--- 130
```
select count(user_id) from dbt_anna_g.stg_users
```

2. On average, how many orders do we receive per hour?
--- 7.5208333333333333
```
with orders_by_hour as (
  select date_trunc('hour', created_at) as created_at_hr, count(order_id) as order_cnt
  from dbt_anna_g.stg_orders
  group by created_at_hr
)

select avg(order_cnt) from orders_by_hour
```

3. On average, how long does an order take from being placed to being delivered?
--- almost 4 days
```
  select 
    avg(delivered_at - created_at) as avg_time_to_delivery
  from dbt_anna_g.stg_orders
```


4. How many users have only made one purchase? Two purchases? Three+ purchases?
--- 1: 25, 2: 28, Else: 71

```
with orders_by_user as (
  select 
    user_id,
    count(order_id) as order_cnt
  from dbt_anna_g.stg_orders
  group by user_id

)

select 
  case when order_cnt = 1 then '1'
      when order_cnt = 2 then '2'
      else '3+' end as order_cnt_cat,
  count(user_id)
from orders_by_user
group by order_cnt_cat
```

5. On average, how many unique sessions do we have per hour?
--- a little over 16
```
with sessions_by_hour as (
  select date_trunc('hour', created_at) as created_at_hr, count(distinct session_id) as session_cnt
  from dbt_anna_g.stg_events
  group by created_at_hr
)

select avg(session_cnt) from sessions_by_hour
```

