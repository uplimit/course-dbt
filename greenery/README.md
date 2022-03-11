Welcome to your new dbt project!

# Weekly projects


## Week 1

* How many users do we have?
130
```sql
select
count (distinct user_id) as total_users
from dbt_eva_j.stg_users;
```

* On average, how many orders do we receive per hour?
7.5
```sql
with hourly_orders as (select 
count(*) as total_orders
from dbt_eva_j.stg_orders
group by date_trunc('hour', created_at))
select avg(total_orders) from hourly_orders;
```

* On average, how long does an order take from being placed to being delivered?
3 days 21:24:11.803279
```sql
select 
avg(delivered_at - created_at) as mean_delivery_time
from dbt_eva_j.stg_orders
where delivered_at is not null;
```

* How many users have only made one purchase? Two purchases? Three+ purchases?
One purchase: 25 users
Two purchases: 28 users
At least three purchases: 71 users
```sql
with orders_per_user as 
(select
user_id,
count(*) as total_orders
from dbt_eva_j.stg_orders
group by user_id)
select 
case when total_orders = 1 then '1 order'
     when total_orders = 2 then '2 orders'
     when total_orders >= 3 then '3+ orders'
     end as total_orders,
count(*)
from orders_per_user
group by 1
order by 1 asc;
```

* On average, how many unique sessions do we have per hour?
16
```sql
with hourly_sessions as (select
count(distinct session_id) as total_sessions
from dbt_eva_j.stg_events
group by date_trunc('hour', created_at))
select avg(total_sessions) from hourly_sessions
```


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
