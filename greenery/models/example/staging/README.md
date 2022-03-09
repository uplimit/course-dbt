# Projects

## Week 1

### How many users do we have?

**130**

```sql
select
    count(distinct user_id)
from
    dbt_derek_m.stg_users;
```

### On average, how many orders do we receive per hour?

**7.5208333333333333**

```sql
with hourly_orders as (
  select
    count(*) as cnt
  from
    dbt_derek_m.stg_orders
  group by
    date_trunc('hour', created_at)
)
select
  avg(cnt)
from
  hourly_orders;
```

### On average, how long does an order take from being placed to being delivered?

**3 days 21:24:11.803279**

```sql
select
  avg(delivered_at - created_at)
from
  dbt_derek_m.stg_orders
where
  delivered_at is not null;
```

### How many users have only made one purchase? Two purchases? Three+ purchases?

- One purchase: **25**
- Two purchases: **28**
- Three or more purchases: **71**

```sql
with user_orders as (
  select
    count(*) as cnt
  from
    dbt_derek_m.stg_orders
  group by
    user_id
)
select
  CASE cnt
    WHEN 1 THEN 1
    WHEN 2 THEN 2
    ELSE 3
  END,
  count(*)
from
  user_orders
group by
  1;
```

### On average, how many unique sessions do we have per hour?

**16.3275862068965517**

```sql
with hourly_sessions as (
  select
    count(distinct session_id) as uniq_cnt
  from
    dbt_derek_m.stg_events
  group by
    date_trunc('hour', created_at)
)
select
  avg(uniq_cnt)
from
  hourly_sessions;
```
