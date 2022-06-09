How many users do we have?
> 130 users

select count(distinct(user_guid)) from dbt_matilda_h.stg_greenery__users

On average, how many orders do we receive per hour?
> About 7.52 orders per hour

with cte_orders as ( 
  select 
  
    date_trunc('hour', created_at_utc) as hourly,
    count(distinct(order_guid)) as nb_orders
  
  from dbt_matilda_h.stg_greenery__orders
  group by 1

)

select round(avg(nb_orders),2) from cte_orders

On average, how long does an order take from being placed to being delivered?
> Average delivery time is around four days (3 days 21:24:11)

with cte_delivery_time as ( 
  select 
  
    date_trunc('hour', created_at_utc) as hour_created,
    date_trunc('hour', delivered_at_utc) as hour_delivered,
    age(delivered_at_utc,created_at_utc) as delivery_time
  
  from dbt_matilda_h.stg_greenery__orders
  where status = 'delivered'

)

select avg(delivery_time) from cte_delivery_time

How many users have only made one purchase? Two purchases? Three+ purchases?
> 25 users have made one purchase, 28 users have made 2 purchases and 71 users have made 3 or more purchases

with cte_user_orders as ( 
  select 
    user_guid,
    count(distinct(order_guid)) as nb_orders
  from dbt_matilda_h.stg_greenery__orders
  group by 1
  -- Chose not to only include delivered or shipped orders as this is still technically an order placed
)

select 
  nb_orders,
  count(nb_orders)
from cte_user_orders
group by 1
order by 1

On average, how many unique sessions do we have per hour?
> 16.32 hourly sessions on average

with cte_sessions as ( 
  select 
  
    date_trunc('hour', created_at_utc) as hourly,
    count(distinct(session_guid)) as nb_sessions
  
  from dbt_matilda_h.stg_greenery__events
  group by 1
)

select round(avg(nb_sessions),2) from cte_sessions