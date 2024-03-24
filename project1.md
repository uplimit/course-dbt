#DBT Course Project 1: 2023-03-23

1. How many users do we have?

Ans: 130
Query: 
```
select 
    count(*) as user_count
from 
dev_db.dbt_vidyagopalan28gmailcom.stg_postgres__users
```

2. On average, how many orders do we receive per hour?

Ans: 15.041667
Query:
```
with order_count as 
(
    select hour(created_at) hour_created_at, count(distinct order_id) as order_count, 
    from dev_db.dbt_vidyagopalan28gmailcom.stg_postgres__orders
    group by hour_created_at
)

select avg(order_count) as avg_orders_per_hour
from order_count
```

3. On average, how long does an order take from being placed to being delivered?

Ans: 3.891803
Query:
```
select 
    avg(datediff('day', created_at, delivered_at)) as avg_days_for_delivery 
from dev_db.dbt_vidyagopalan28gmailcom.stg_postgres__orders 
where order_status = 'delivered'
```

4. How many users have only made one purchase? Two purchases? Three+ purchases?

Note: you should consider a purchase to be a single order. In other words, if a user places one order for 3 products, they are considered to have made 1 purchase.


Ans: 
    Users with purchase count 1: 25
    Users with purchase count 2: 28
    Users wuth purchase count >3: 71

Query:
```

create temporary table temp_purchase_count as 
with user_purchasecount as 
(
select 
    user_id, count(distinct order_id) as purchase_count
from stg_postgres__orders
group by user_id
)

select 
purchase_count, count(user_id) as user_count
from user_purchasecount
group by purchase_count
order by purchase_count

select * from temp_purchase_count;

a.
select 
user_count,
from temp_purchase_count
where purchase_count = 1;

b.
select 
sum(user_count),
from temp_purchase_count
where purchase_count = 2;

c. 
select 
sum(user_count),
from temp_purchase_count
where purchase_count >= 3;

```
5. On average, how many unique sessions do we have per hour?

Ans: 39.458333
Query:
```
with session_count as 
(
    select hour(created_at) hour_created_at, count(distinct session_id) as session_count, 
    from dev_db.dbt_vidyagopalan28gmailcom.stg_postgres__events
    group by hour_created_at
)

select 
    avg(session_count) as avg_sessions_per_hour
from session_count
```