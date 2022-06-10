How many users do we have?
A: 130
<!-- SQL: select count(distinct user_id) from dbt_charlie_m.tbl_users -->

On average, how many orders do we receive per hour?
A: 7.5
SQL: 
<!-- 
with hour_orders as (
select 
  date_trunc('hour', created_at) as order_hour,
  count(order_id) as order_count
from dbt_charlie_m.tbl_orders
group by 1
)
select avg(order_count)
from hour_orders 
-->

On average, how long does an order take from being placed to being delivered?
A: 3 days, 21 hours
SQL:
<!-- with x as (
select 
  order_id,
  date_trunc('hour', delivered_at_utc) - date_trunc('hour', created_at) as diff,
  created_at

from dbt_charlie_m.tbl_orders
where status = 'delivered'
)
select avg(diff) from x -->

How many users have only made one purchase? Two purchases? Three+ purchases?
A: 1 order: 25; 2 orders: 28; 3+ orders: 71
SQL:
<!-- 
with user_order_count as (
select
  user_id,
  count(order_id) as order_count

from dbt_charlie_m.tbl_orders
group by 1
)

select
  count(case when order_count = 1 then user_id else null end) as one_order,
  count(case when order_count = 2 then user_id else null end) as two_orders,
  count(case when order_count >= 3 then user_id else null end) as three_plus_orders
from user_order_count -->

On average, how many unique sessions do we have per hour?
A: 16.3
SQL:
<!-- 
with hour_sessions as (
select
  date_trunc('hour', created_at_utc) as hour,
  count(distinct session_id) as unique_sessions
from dbt_charlie_m.tbl_events
group by 1
)

select
  avg(unique_sessions) as avg_session_count
from hour_sessions
 -->
