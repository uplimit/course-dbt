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
3.89 days 

``` sql
/*create a cte where each row is an order and there is a column 
for time difference between when an order is placed vs. delivered 
*/
with order_deliver_time as (
select 
  order_id
  , delivered_at::date - created_at::date as order_deliver_diff 
from dbt_mahelet_f.stg_orders
where status = 'delivered'
)
-- calculate average 
select avg(order_deliver_diff)
from order_deliver_time
```

### How many users have only made one purchase? Two purchases? Three+ purchases?

Note: you should consider a purchase to be a single order. In other words, if a user places one order for 3 products, they are considered to have made 1 purchase.
* 25 users have only made 1 purchase 
* 28 users have made two purchases 
* 71 users have made three+ purchases


``` sql 
-- Create CTE to calcuate for each user, how many orders have they made
with user_order as (

select 
  user_id
  , count(distinct order_id) as num_orders 
from dbt_mahelet_f.stg_orders 
group by 1
)

select 
  case 
    when num_orders = 1 then '1'
    when num_orders = 2 then '2'
    when num_orders >= 3 then '3+'
    end as user_order_count 
  , count(*)
from user_order 
group by 1 
order by 1 asc 
```

### On average, how many unique sessions do we have per hour?
16.32

``` sql 
-- calculate number of unique sessions per hour 
with session_hour as (
select 
  date_trunc('hour',  created_at) as date_hour
  , count(distinct session_id) as num_sessions
from dbt_mahelet_f.stg_events
group by 1 
)

-- calculate average 
select avg(num_sessions)
from session_hour
```