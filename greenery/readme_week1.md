How many users do we have?

Answer: We have 130 users.
SQL:
```
select count(*) from dbt_juliepanteleevagmailcom.stg_postgres__users
```



On average, how many orders do we receive per hour?
Answer: 7.520833
SQL:
```
with cte as (select date_trunc('hour', created_at) as hour, count(distinct order_id) as cnt from dbt_juliepanteleevagmailcom.stg_postgres__orders
group by 1)
select avg(cnt) as average_per_hour from cte 
```


On average, how long does an order take from being placed to being delivered?

Answer: 93.4 hours or 3.89 days.
```
select avg(datediff(hour, created_at, delivered_at)) as average_hours, avg(datediff(days, created_at, delivered_at)) as average_days from dbt_juliepanteleevagmailcom.stg_postgres__orders
where delivered_at is not null

```

How many users have only made one purchase? Two purchases? Three+ purchases?

Answer: 1 purchase - 25 users, 2 purchases 28 users, 3+ purchases - 71 users.

```
with cte as (select user_id, count (distinct order_id) as cnt_orders  from dbt_juliepanteleevagmailcom.stg_postgres__orders
group by 1)
select count(distinct user_id) as cnt_users, case when cnt_orders = 1 then '1' when cnt_orders = 2 then '2' 
else '3+' end as purchases
from cte
group by 2
order by 2
```

On average, how many unique sessions do we have per hour?

Answer: 16.3
```
with sessions as (
select count(distinct session_id) as number, date_trunc('hour', created_at) as hour from dbt_juliepanteleevagmailcom.stg_postgres__events
group by 2)
select avg(number) from sessions
```