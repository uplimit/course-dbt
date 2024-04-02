# Analytics engineering with dbt

### Week 1 Challenges



#### Question 1: How many users do we have?
** Answer: 130 users 

```sql
select count(distinct user_id) 
from stg_users;
```
#### Question 2: On average, how many orders do we receive per hour?
** Answer: ~7.5 orders

```sql
with order_hour as (

SELECT 
    date_trunc('hour', created_at) as created_hour, 
    count(distinct order_id) as orders 
FROM stg_orders
GROUP BY 1 
ORDER BY 1 
) 

select 
    avg(orders) as avg_orders_per_hour
from order_hour
order by 1;
```
#### Question 3: On average, how long does an order take from being placed to being delivered?
** Answer: ~3.9 days

```sql
with order_delivery_days as (
SELECT  
    ORDER_ID,
    DATEDIFF(DAY,MIN(CREATED_AT),MIN(DELIVERED_AT)) AS DELIVERY_TIME
from stg_orders 
group by order_id 
) 

select avg(delivery_time) 
from order_delivery_days;
```

#### Question 4: How many users have only made one purchase? Two purchases? Three+ purchases?
** Answer: One: 25, Two: 28, Three+: 71

```sql
with user_orders as (
select 
    user_id, 
    count(distinct order_id) as order_count 
from stg_orders 
group by user_id 
order by count(distinct order_id) desc 
)

select 
    count(case when order_count = 1 then user_id end) as one_purchase,
    count(case when order_count = 2 then user_id end) as two_purchases,
    count(case when order_count >= 3 then user_id end) as three_or_more_purchases
from user_orders;
```
#### Question 5: On average, how many unique sessions do we have per hour?
** Answer: 16.3 sessions per hour

```sql
select 
    date_trunc(hour, created_at) as created_hour, 
    count(distinct session_id) as unique_sessions, 
    avg(unique_sessions) over () as avg_unique_sessions 
from stg_events
group by 1 
order by 1 
```







## License
GPL-3.0
