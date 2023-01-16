Solutions to week 1 project 
1. How many users do we have?
select count(distinct user_id) from stg_postgres_users

Solution: 130

2. On average, how many orders do we receive per hour?
with hourly_total as (
    select  
    trunc(created_at_utc,'hour'),
    count(*) as order_count
    from stg_postgres_orders
    group by 1)
    select avg(order_count)
        from hourly_total

Solution: 7.520833

3. On average, how long does an order take from being placed to being delivered?
with delivered as 
(
    select 
        order_id,
        datediff('days', created_at_utc, delivery_at_utc ) as delivery_day
    from stg_postgres_orders
)

select round(avg(delivery_day),1) as avg_delivery_day from delivered

Solution: 3.9

4. How many users have only made one purchase? Two purchases? Three+ purchases?
with user_orders as (
    select 
        user_id, 
        count(*) order_count
    from stg_postgres_orders
    group by 1 
)

select 
    case order_count
        when 1 then '1 Purchase'
        when 2 then '2 Purchases'
        else '3+ Purchases' 
        end as order_bin,
    count(user_id)
from user_orders
group by 1

solution: 1 Purchase, 25 2 Purchases, 28 3+ Purchases, 71 

4. On average, how many unique sessions do we have per hour?
with events_per_hour as (
    select
        date_trunc('hour', event_created_at_utc) as event_hour,
        count(distinct session_id) as unique_session_count
    from stg_postgres_events
    group by 1
)

select avg(unique_session_count) as sessions_per_hour from events_per_hour

solution: 16.327586