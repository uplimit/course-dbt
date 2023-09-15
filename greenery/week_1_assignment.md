Question 1: How many users do we have?
    Answer: 130
       SQL:
            ```
            select 
                count(distinct user_id)
            from
                DEV_DB.DBT_AMELIASIGMACOMPUTINGCOM._POSTGRES__USERS_MODEL
            ```

Question 2: On average, how many orders do we receive per hour?
    Answer: 7.52
       SQL:
            ```
            with orders_grouped_by_hour as (
                select
                    count(distinct order_id) as orders_per_hour,
                    date_trunc('hour', created_at) as order_hour
                from
                    DEV_DB.DBT_AMELIASIGMACOMPUTINGCOM._POSTGRES__ORDERS_MODEL
                group by 2
            )
            select Round(Avg(orders_per_hour), 2)
            from orders_grouped_by_hour
            ```

Question 3: On average, how long does an order take from being placed to being delivered?
    Answer: 3.89 days
    ```
    with delivery_times as (
        select
            order_id,
            datediff('hour', created_at, delivered_at) / 24 as days_to_delivery
        from
            DEV_DB.DBT_AMELIASIGMACOMPUTINGCOM._POSTGRES__ORDERS_MODEL
        group by all
    )
    select Round(Avg(days_to_delivery), 2)
    from delivery_times
    ```
    
Question 4: How many users have only made one purchase? Two purchases? Three+ purchases?
    Answer: 25, 28, 71 (respectively)
    ```
    with user_purchases as (
        select
            user_id,
            count(distinct order_id) as count_of_user_purchases
        from
            DEV_DB.DBT_AMELIASIGMACOMPUTINGCOM._POSTGRES__EVENTS_MODEL
        group by all
    )
    select
        count_if(count_of_user_purchases = 1) as users_with_one_purchase,
        count_if(count_of_user_purchases = 2) as users_with_two_purchases,
        count_if(count_of_user_purchases >= 3) as users_with_three_or_more_purchases
    from
        user_purchases
    ```

Question 5: On average, how many unique sessions do we have per hour?
    Answer: 16.33
    ```
with sessions_grouped_by_hour as (
    select
        count(distinct session_id) as unique_sessions,
        date_trunc('hour', created_at) as hour_of_created_at
    from
        DEV_DB.DBT_AMELIASIGMACOMPUTINGCOM._POSTGRES__EVENTS_MODEL
    group by all
)
select
    Round(Avg(unique_sessions), 2) as average_unique_sessions_per_hour
from
    sessions_grouped_by_hour
    ```