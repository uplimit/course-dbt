Welcome to your new dbt project!

### Using the starter project

Questions to week 1 project:
Q: How many users do we have?
A: 130

    select
        count(distinct user_guid)
    from DEV_DB.DBT_BAVERY.SRC_USERS;


Q: On average, how many orders do we receive per hour?
A: 7.52


        with orders as (
            select
                date_trunc('hour',created_at_tstamp_est) as hour,
                count(distinct order_guid) as orders
            from DEV_DB.DBT_BAVERY.SRC_ORDERS
            group by 1
        )

        select
            avg(orders) as avg
        from orders

Q: On average, how long does an order take from being placed to being delivered?
A: 3.89

    with dates as (
        select
            datediff('day',created_at_tstamp_est,delivered_at_tstamp_est) as days,
            order_guid
        from DEV_DB.DBT_BAVERY.SRC_ORDERS
    )

    select
        avg(days)
    from dates;



Q: How many users have only made one purchase? Two purchases? Three+ purchases?
A: 1 order- 25, 2 orders - 28, 3+ orders - 71


    
    with user_order as (
        select
        user_guid,
        count(distinct order_guid) as orders
    from DEV_DB.DBT_BAVERY.SRC_ORDERS
        GROUP BY 1
    )  
    
    select
        case 
            when orders >= 3 then '3+'
            else orders::text
        end as orders,
        count(distinct user_guid) as users
    from user_order
    group by 1
    order by 1 

Q: On average, how many unique sessions do we have per hour?
A: 16.33

    with sessions as (
        select
            date_trunc('hour',created_at_tstamp_est) as hour,
            count(distinct session_guid) as sessions
        from DEV_DB.DBT_BAVERY.SRC_EVENTS
        group by 1

        )
        
        select
            avg(sessions)
        from sessions


### Resources:
- Learn more about dbt [in the docs](https://docs.getdbt.com/docs/introduction)
- Check out [Discourse](https://discourse.getdbt.com/) for commonly asked questions and answers
- Join the [chat](https://community.getdbt.com/) on Slack for live discussions and support
- Find [dbt events](https://events.getdbt.com) near you
- Check out [the blog](https://blog.getdbt.com/) for the latest news on dbt's development and best practices
