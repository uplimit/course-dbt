## WEEK 1 Results
1. How many users do we have?
    130 users
    select count(distinct user_id) from dbt_javier_g.stg_users
2. On average, how many orders do we receive per hour?
    7.52 orders
    with final as (select 
        date_trunc('hour',created_at)
        , count(*) as orders
    from dbt_javier_g.stg_orders
    group by 1)
    select round(avg(orders),2) from final

3. On average, how long does an order take from being placed to being delivered?
    3 days
    select 
        avg(delivered_at - created_at) as avg_preparation_time
    from dbt_javier_g.stg_orders

4. How many users have only made one purchase? Two purchases? Three+ purchases?
    Total users 1 purchase: 25
    Total users 2 purchases: 28
    Total users 3+ purchases: 37
    with final as (
        select 
            user_id
            , count(*) total_orders
        from dbt_javier_g.stg_orders
        group by 1
        )
    select
    count(case when total_orders = 1 then 1 end) as orders_1
    , count(case when total_orders = 2 then 1 end) as orders_2
    , count(case when total_orders > 3 then 1 end) as orders_3_plus
    from final

5. On average, how many unique sessions do we have per hour?
    16.33 sessions/hour as average
    with final as (
        select 
            date_trunc('hour',created_at)
            , count(distinct session_id) as total_sessions
        from dbt_javier_g.stg_events
        group by 1
    )
    select
        round(avg(total_sessions),2)
    from final