**WEEK 01 HOMEWORK QUESTIONS**

1. How many users do we have? **130 users**
```
select count(distinct user_id) from dbt_jason_d.stg_public__users;
```

2. On average, how many orders do we receive per hour? **Average of 7.5 Orders per Hour**

```
with order_count_by_hour as (

    select 
        concat(date_part('day', created_at), '-', date_part('hour', created_at)) as day_hour,
        count(distinct order_id) as order_count
    from dbt_jason_d.stg_public__orders
    group by day_hour

),

aggregated_totals as (
    select 
        sum(order_count) as total_orders, 
        count(day_hour) as total_hours 
    from order_count_by_hour
)

select 
  round((total_orders / total_hours),1) as avg_orders_per_hour 
from aggregated_totals;
```



On average, how long does an order take from being placed to being delivered?

How many users have only made one purchase? Two purchases? Three+ purchases?

Note: you should consider a purchase to be a single order. In other words, if a user places one order for 3 products, they are considered to have made 1 purchase.

On average, how many unique sessions do we have per hour?