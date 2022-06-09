# Answer these questions using the data available using SQL queries. You should query the dbt generated (staging) tables you have just created. For these short answer questions/queries create a separate readme file in your repo with your answers.

## How many users do we have?

```sql
select count(distinct(user_guid)) from dbt_eike_r.stg_greenery__users;
```
Answer:
> 130

## On average, how many orders do we receive per hour?


```sql
select round(avg(count_per_hour),2) from(
  select count(*) as count_per_hour, date_trunc('hour', order_created_at_utc) as order_date
  from dbt_eike_r.stg_greenery__orders
  group by 2
  order by 2) as t;
```
Answer:
> 7.52

## On average, how long does an order take from being placed to being delivered?

```sql
select avg(delivery_time) from(
  select order_guid, order_created_at_utc, delivered_at_utc, delivered_at_utc-order_created_at_utc as delivery_time
  from dbt_eike_r.stg_greenery__orders
  where order_status = 'delivered') as t;
```
Answer:
> 3 days 21:24:11.803279

## How many users have only made one purchase? Two purchases? Three+ purchases?

```sql
select t.order_count, count(user_guid) user_count_per_order_count from(
  select user_guid,count(order_guid) as order_count from dbt_eike_r.stg_greenery__orders
  group by user_guid) as t
  group by t.order_count
  order by t.order_count
```

Answer:
| order_count  | number_of_users  |
|---|---|
| 1 | 25  |
| 2 | 28  |
| 3 | 34  |
| 4 | 20  |
| 5 | 10  |
| 6 | 2  |
| 7 | 4  |
| 8 | 1  |


## On average, how many unique sessions do we have per hour?

```sql
select round(avg(count_per_hour),2) from(
  select count(distinct(session_guid)) as count_per_hour, date_trunc('hour', event_created_at_utc) as event_date
  from dbt_eike_r.stg_greenery__events
  group by 2
  order by 2) as t;
```

Answer:
> 16.33