### Week 1 Project

### 1. How many users do we have?

130 users
```
select count(distinct user_id)
from DEV_DB.DBT_PLE.STG_USERS
```

### 2. On average, how many orders do we receive per hour?
On average, there are 15 orders per hour 
```
with orders as (
select hour(created_at) as hour,
count(order_id) as orders
from DEV_DB.DBT_PLE.STG_ORDERS
group by 1)

select avg(orders)
from orders 
```

### 3. On average, how long does an order take from being placed to being delivered?
On average, it takes 93.4 hours 
```
with deliver_time as (
    select order_id, datediff(hour, created_at, delivered_at) deliver_time
    from DEV_DB.DBT_PLE.STG_ORDERS)
    
select avg(deliver_time)
from deliver_time
```

### 4. How many users have only made one purchase? Two purchases? Three+ purchases?
- 25 users only made one purchase 
- 28 users made two purchases 
- 71 users made three or more purchases
```
with orders as (
select  user_id,count(order_id) orders_per_user
    from DEV_DB.DBT_PLE.STG_ORDERS
    group by user_id
)
select 
    count ( case when orders_per_user = 1  then user_id else null end ) as one_purchase,
    count ( case when orders_per_user = 2  then user_id else null end ) as two_purchases,
    count ( case when orders_per_user >= 3  then user_id else null end ) as three_or_more_purchases
from orders
```

### 5. On average, how many unique sessions do we have per hour?
On average, there are 39.5 unique sessions per hour 
```
with sessions as (
select hour(created_at) as hour,
count(distinct session_id) as unique_sessions
from DEV_DB.DBT_PLE.STG_EVENTS
group by 1)

select avg(unique_sessions)
from sessions 
```
