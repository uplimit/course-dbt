Welcome to your new dbt project!

### Using the starter project

Try running the following commands:
- dbt run
- dbt test


### Resources:
- Learn more about dbt [in the docs](https://docs.getdbt.com/docs/introduction)
- Check out [Discourse](https://discourse.getdbt.com/) for commonly asked questions and answers
- Join the [chat](https://community.getdbt.com/) on Slack for live discussions and support
- Find [dbt events](https://events.getdbt.com) near you
- Check out [the blog](https://blog.getdbt.com/) for the latest news on dbt's development and best practices

### Week #1 Answers:

-How many users do we have?
    A: 130 
    
    select count(*) from dbt."dbt_Marios_A".stg_users;

-On average, how many orders do we receive per hour?
    A: On average we receive 7.52 orders per hour
    
            select avg(a.count) as avg_orders
            from(
            select date_trunc('hour',created_at) as hour,count(distinct order_id) as count
            from dbt."dbt_Marios_A".stg_orders
            group by 1) a ;

-On average, how long does an order take from being placed to being delivered?
    A: On average we need approx 3 days 21 hours to deliver an order
            
            select avg(a.days_to_deliver) as avg_days_to_deliver
            from(
            select order_id,created_at, delivered_at ,(delivered_at -created_at) as days_to_deliver
            from dbt."dbt_Marios_A".stg_orders
            where delivered_at is not null -- removing all orders that have not been delivered 
            ) a ;
    
-How many users have only made one purchase? Two purchases? Three+ purchases?
    A: 1->25
       2->28
       3+->71
              
       select CASE WHEN count_of_orders = 1 then '1'
                    WHEN count_of_orders = 2 then '2'
                    ELSE '3+' END
                , count(distinct user_id) as number_of_users
        from(            
            select user_id,count(distinct order_id) as count_of_orders
            from dbt."dbt_Marios_A".stg_orders 
            group by 1
        ) a 
        group by 1;
        
-On average, how many unique sessions do we have per hour?
    A: On average we have 16.32 sessions per hour
        
    select avg(count_of_sessions) as avg_count_of_sessions
    from(
    select date_trunc('hour', created_at) as hour ,count(distinct session_id) as count_of_sessions
    from dbt."dbt_Marios_A".stg_events 
    group by 1
    ) a ;
    
