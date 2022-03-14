# Week 1 Project 

### How many users do we have? 
130

``` sql
select count(distinct users)
from dbt_mahelet_f.stg_users
```

### On average, how many orders do we receive per hour?
7.5 


``` sql
--- create a cte to calculate how many orders greenery gets per hour 
with orders_hour as (
select 
  date_trunc('hour',  created_at) as date_hour
  , count(distinct order_id) as num_orders
from dbt_mahelet_f.stg_orders 
group by 1 
)

select avg(num_orders)
from orders_hour
```

### On average, how long does an order take from being placed to being delivered?



How many users have only made one purchase? Two purchases? Three+ purchases?

Note: you should consider a purchase to be a single order. In other words, if a user places one order for 3 products, they are considered to have made 1 purchase.

On average, how many unique sessions do we have per hour?