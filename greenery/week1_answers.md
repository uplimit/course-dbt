## Week1 Project Questions

### Some of the questions that can be answered with the staging models.

<br>

> How many users do we have?

```
select count(user_id) as total_users
from dbt_mukunda_r.stg_users su 
```

> On average, how many orders do we receive per hour?

```
with order_min_max as
(select count(order_id) tot_orders, max(created_at) max_created, min(created_at) min_created
from dbt_mukunda_r.stg_orders so ),
orders_time_taken as
(select om.tot_orders, extract (epoch from (max_created-min_created)) total_seconds 
 from order_min_max om 
)

select round((tot_orders /(total_seconds/3600))::decimal, 2) as orders_per_hour
from orders_time_taken 
```

> On average, how long does an order take from being placed to being delivered?

```
select round((avg(seconds_taken)/(3600*24))::decimal, 2) as avg_delivery_days
from 
(select order_id, extract ( epoch from (delivered_at - created_at)) seconds_taken
from dbt_mukunda_r.stg_orders so where so.status = 'delivered') tt
```


> How many users have only made one purchase? Two purchases? Three+ purchases?

```
with user_orders as 
(select user_id, count(order_id) tot_orders
from stg_orders so 
group by user_id )

select  case when tot_orders = 1 then 'Single' when tot_orders = 2 then 'Double' else 'Three+' end order_class, count(user_id) num_users
from user_orders uo
group by case when tot_orders = 1 then 'Single' when tot_orders = 2 then 'Double' else 'Three+' end 
```


> On average, how many unique sessions do we have per hour?

```
select round((avg(sessions))::decimal ,2) sessions_per_hour
from 
(select date_trunc('hour', created_at) as hrs, count(distinct session_id) as sessions 
from dbt_mukunda_r.stg_events se 
group by hrs) n
```
