# Analytics engineering with dbt

--Q1 How many users do we have?
select COUNT(DISTINCT user_id) as users from dbt.dbt_sofia.stg_greenery_users;
--R:130
-- Q2 On average, how many orders do we receive per hour?
with hours as (select 
date_trunc('hour',created_at) as hour_order, 
count(distinct order_id) as orders
from dbt.dbt_sofia.stg_greenery_orders
group by 1 )

select 
sum(orders)/24 as odersperhour
 from hours 
 --R2:15.0416666666666667
 
 --Q3 On average, how long does an order take from being placed to being delivered?
 with delivertime as ( 
 select 
 order_id,
 (date_trunc('day',delivered_at)-date_trunc('day',created_at)) as  daystodeliver
 from dbt.dbt_sofia.stg_greenery_orders)
 
 select 
 sum( daystodeliver)/count(distinct order_id)
 from delivertime
 
 --R3:3 days 06:54:50.858726
 --Q4 How many users have only made one purchase? Two purchases? Three+ purchases?
 with orderperuser as( 
 select 
  user_id,count(distinct order_id) as orders 
 from dbt.dbt_sofia.stg_greenery_orders
 group by user_id
 )
 select orders, count(distinct user_id) as users
 from orderperuser
 group by orders
 --R:
 <img width="601" alt="image" src="https://user-images.githubusercontent.com/106842349/173165777-8deddb4d-a0eb-4ada-914a-8a0c94f2804d.png">

 --Q5 On average, how many unique sessions do we have per hour?
 
 
 select 
  count(distinct session_id)/
  date_part('hour',(date_trunc('hour',min(created_at))-date_trunc('hour',max(created_at)))) as avgsessionperhour
 from dbt.dbt_sofia.stg_greenery_events
 
--R5:64.22222222222223
## License

Apache 2.0
