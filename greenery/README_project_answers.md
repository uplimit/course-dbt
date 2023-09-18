1] How many users do we have?
    - We have 130 distinct users
    select count(distinct user_id)
    from DEV_DB.DBT_KLYMPERIFLEXPORTCOM.STG_USERS

2] On average, how many orders do we receive per hour?
    - On average receive 7.5 orders per hour
    with 
    cte_orders_per_hour as (
    select
    date_trunc('hour', created_at) as order_hour,
    count(distinct order_id) as total_hourly_orders
    from DEV_DB.DBT_KLYMPERIFLEXPORTCOM.stg_orders
    group by 1
    )
    select 
        round(avg(total_hourly_orders),1) as avg_hourly_orders
    from cte_orders_per_hour;

3] On average, how long does an order take from being placed to being delivered?
    - On average we take 3.9 days to deliver the goods from the time of placing the order
    select
    round(avg(datediff(days, created_at, delivered_at)),1) as days_to_delivery
    from DEV_DB.DBT_KLYMPERIFLEXPORTCOM.stg_orders

4] How many users have only made one purchase? Two purchases? Three+ purchases?
   - In our historical data we have 25 users that placed 1 order, 28 users with 2 orders while 71 ordered more than 3.
   with order_count as (
    select
        user_id,
        count(order_id) as total_orders
    from DEV_DB.DBT_KLYMPERIFLEXPORTCOM.stg_orders
    group by 1)

    select
        sum(case when total_orders = 1 then 1 else 0 end) as nr_users_1_order,
        sum(case when total_orders = 2 then 1 else 0 end) as nr_users_2_order,
        sum(case when total_orders >= 3 then 1 else 0 end) as nr_users_3_order
    from order_count;

5] On average, how many unique sessions do we have per hour?
    -We average at 61.3 sessions per hour
    with
        cte_hourly_sessions as (
        select
        date_trunc('hour', created_at) as hourly_session,
        count(session_id) as total_sessions
    from DEV_DB.DBT_KLYMPERIFLEXPORTCOM.stg_events
    group by 1)

    select 
        round(avg(total_sessions),1) as avg_hourly_sessions
    from cte_hourly_sessions;

