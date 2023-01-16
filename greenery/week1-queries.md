# Answers to questions in Week -1 

## How many users do we have?

```sql
select count(distinct user_id) from dev_db.dbt_oneryalcingmailcom.stg_users;
```
- Answer: **130**

## On average, how many orders do we receive per hour?

```sql
WITH 
 order_by_hour AS (
    select  
        count(*) as count_by_hour, 
        date_part(HOUR, created_at) 
    from dev_db.dbt_oneryalcingmailcom.stg_orders
    group by 2 
 )
 select avg(count_by_hour) from order_by_hour;
```

- Answer: **15.041667**


## On average, how long does an order take from being placed to being delivered?

```sql
select 
    avg(timestampdiff(days, created_at, delivered_at))
from orders
where delivered_at is not NULL;
```

- Answer: **3.891803 days on average**

## How many users have only made one purchase? Two purchases? Three+ purchases?
>  Note: you should consider a purchase to be a single order. In other words, if a user places one order for 3 products, they are considered to have made 1 purchase.

```sql
with order_cnt_by_user as (
    select 
        user_id, 
        count(*) as order_cnt 
    from dev_db.dbt_oneryalcingmailcom.stg_orders 
    group by user_id
)
select 
    count(*) as total_orders, 
    order_cnt 
from order_cnt_by_user 
group by order_cnt 
order by order_cnt;
```

Answer: 1 Orders: 25, 2 Orders: 28, 3+ orders: 71

## On average, how many unique sessions do we have per hour?

```sql
with sessions_by_hour as (
    select
        session_id,
        DATE_TRUNC('HOUR', created_at) AS hour_trnc 
    from dev_db.dbt_oneryalcingmailcom.stg_events
),
session_count_by_hour as (
    select 
        hour_trnc, 
        count(distinct(session_id)) as unique_session_cnt
    from 
        sessions_by_hour
    group by hour_trnc
)
select 
    avg(unique_session_cnt) 
```

Answer: **16.327586**




