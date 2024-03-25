1. How many users do we have?

   Query:

   ```sql
   select count(user_id) from stg_users;
   ```

   Result: 130

2. On average, how many orders do we receive per hour?

   Query:

   ```sql
   select avg(orders)
   from
       (
           select date_trunc('hour', created_at) as hour, count(order_id) as orders
           from stg_orders
           group by hour
       )
   ;
   ```

   Result: 7.520833

3. On average, how long does an order take from being placed to being delivered?

   Query:

   ```sql
   select
       floor(seconds / 3600)
       || ':'
       || lpad(floor((seconds % 3600) / 60), 2, '0')
       || ':'
       || lpad(seconds % 60, 2, '0')
       || ' HH:MM:SS'
   from
       (
           select avg(datediff('second', created_at, delivered_at)) as seconds
           from stg_orders
           where delivered_at is not null
       )
   ;
   ```

   Result: 93:24:11 HH:MM:SS

4. How many users have only made one purchase? Two purchases? Three+ purchases?

   - _Note: you should consider a purchase to be a single order. In other words, if a user places one order for 3 products, they are considered to have made 1 purchase._

   Query:

   ```sql
   select count(*)
   from (select user_id from stg_orders group by user_id having count(order_id) = 1)
   ;
   select count(*)
   from (select user_id from stg_orders group by user_id having count(order_id) = 2)
   ;
   select count(*)
   from (select user_id from stg_orders group by user_id having count(order_id) >= 3)
   ;
   ```

   Result:

   - 25
   - 28
   - 71

5. On average, how many unique sessions do we have per hour?

   Query:

   ```sql
   select avg(sessions)
   from
       (
           select
               date_trunc('hour', created_at) as hour,
               count(distinct session_id) as sessions
           from stg_events
           group by hour
       )
   ;
   ```

   Result: 16.327586
