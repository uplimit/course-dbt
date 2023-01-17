--------------------------------------------------------------------------  
 1. How many users do we have? 130 Users
--------------------------------------------------------------------------
    select 
        count(distinct user_id) as users_ct --130
    from dev_db.dbt_amoskimcheckrcom.staging_postgres_users;
--------------------------------------------------------------------------
 2. On average, how many orders do we receive per hour? 7.53 Orders/hr
--------------------------------------------------------------------------
    SELECT
        first_order,     --2021-02-10 00:00:05.000
        last_order,      --2021-02-11 23:55:36.000
        order_ct / total_diff_hrs as avg_orders_per_hr --7.53 AVG orders per hour
    from (
        select 
            min(created_at) first_order,
            max(created_at) last_order,
            datediff('minute', first_order,last_order)/60.00 as total_diff_hrs,
            count(distinct order_id) order_ct
        from dev_db.dbt_amoskimcheckrcom.staging_postgres_orders
    );
--------------------------------------------------------------------------
 3. On average, how long does an order take from being placed to being delivered? 93.4 hrs
--------------------------------------------------------------------------
    select 
        (avg(datediff('minute', created_at, delivered_at)) / 60.00) as avg_delivery_time_hr --93.4
    from dev_db.dbt_amoskimcheckrcom.staging_postgres_orders
    where datediff('second', created_at, delivered_at) > 0  
;
--------------------------------------------------------------------------
 4. How many users have only made one purchase? Two purchases? Three+ purchases?
 (1 order,25 users), (2 orders, 28 users), (3+ orders, 71 users)
--------------------------------------------------------------------------
    select 
        iff(order_ct>=3, '3+', order_ct::varchar) as order_ct,
        count(*)
    from 
        (select 
            user_id,
            count(distinct order_id) as order_ct
        from dev_db.dbt_amoskimcheckrcom.staging_postgres_orders
        group by user_id )
    group by 1
    order by 1 asc
)
--------------------------------------------------------------------------
 5. On average, how many unique sessions do we have per hour? 
 10.14 sessions per hour
--------------------------------------------------------------------------
    SELECT
        first_session,     --2021-02-09 23:55:08.000
        last_session,      --2021-02-12 08:55:36.000
        session_ct / total_diff_hrs as avg_orders_per_hr --10.14 AVG sessions per hour
    from (
        select 
            min(created_at) first_session,
            max(created_at) last_session,
            datediff('minute', first_session,last_session)/60.00 as total_diff_hrs,
            count(distinct SESSION_ID) session_ct
        from dev_db.dbt_amoskimcheckrcom.staging_postgres_events 
    )
;     
