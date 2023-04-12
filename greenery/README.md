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

### Week 1 Project 
- How many users do we have? 130 unique users
- On average, how many orders do we receive per hour? 7.52 per hour
- On average, how long does an order take from being placed to being delivered? ~3.89 days
- How many users have only made one purchase? 25 Two purchases? 28 Three+ purchases? 71

ORDER_COUNT|CUSTOMER_COUNT
--- | --- 
1|25
2|28
3|34
4|20
5|10
6|2
7|4
8|1

_Note: you should consider a purchase to be a single order. In other words, if a user places one order for 3 products, they are considered to have made 1 purchase._

- On average, how many unique sessions do we have per hour? ~16.3 unique sessions per hour

<details>
  <summary>SQL</summary>

  ```
-- distinct users
select count(distinct user_id) unique_users from DEV_DB.DBT_MONICAKIM4GMAILCOM.POSTGRES__USERS
-- 130

-- avg orders per hour
select
avg(order_count)
from (
  select 
  date_trunc ('hour',created_at) created_hour, 
  count(order_id) order_count
  from DEV_DB.DBT_MONICAKIM4GMAILCOM.POSTGRES__ORDERS
  group by 1
  ) a
-- 7.520833

-- avg delivery time
select 
avg(datediff(day,created_at, delivered_at)) as avg_deliverytime
from DEV_DB.DBT_MONICAKIM4GMAILCOM.POSTGRES__ORDERS
where order_status = 'delivered'
-- 3.89


-- customers that have made n number of orders
select 
order_count
,count(user_id) customer_count
from (
  select 
  user_id,
  count(order_id) as order_count
  from DEV_DB.DBT_MONICAKIM4GMAILCOM.POSTGRES__ORDERS
  group by 1
  ) a
group by 1
order by 1

-- unique sessions per hour
select 
avg(unique_sessions) avg_sessionsperhour
from (
select
date_trunc ('hour',created_at) created_hour, 
count(distinct session_id) as unique_sessions
from DEV_DB.DBT_MONICAKIM4GMAILCOM.POSTGRES__EVENTS
group by 1
) a
  ```
</details>
