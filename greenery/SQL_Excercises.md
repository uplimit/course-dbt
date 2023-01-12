### Week 1: SQL Excercises
**Question 1: How many users do we have?**

We have **130  unique users**.

Query:

`
SELECT 
    COUNT(DISTINCT USER_GUID)
FROM dev_db.dbt_janio.stg_postgres__users;`

**Question 2: On average how many orders do we receive per hour?**

On average we have **7.52 orders** 

Query:

<code>
WITH users_tbl AS ( <br>
    SELECT  <br>
        trunc(created_at_utc, 'hour'), <br>
        COUNT(ORDER_GUID) AS cnt_users <br>
    FROM dev_db.dbt_janio.STG_POSTGRES__ORDERS <br>
    GROUP BY 1 <br>
)
select AVG(cnt_users) AS avg_users  <br>
from users_tbl;

</code>
<br>

**Question 3: On average, how long does an order take from being placed to being delivered?**

**3.89 days** on average in which the order was created until it was actually delivered.

Query:

<code>

WITH timestamp_diff_tbl as (

SELECT <br>
    created_at_utc, <br>
    delivered_at_utc, <br>
    timestampdiff('day', created_at_utc, delivered_at_utc) as difference_days <br>
FROM dev_db.dbt_janio.stg_postgres__orders
    )

SELECT <br>
    AVG(difference_days) AS avg_day_difference <br>
FROM timestamp_diff_tbl

</code>


**Question 4: How many users have only made one purchase? Two Purchases? Three+ purchases?**


**Result:** <br>
Users with 1 order: 25 <br>
Users with 2 orders: 28<br>
Users with 3 orders: 34 <br>
Users with 4 orders: 20 <br>
Users with 5 orders: 10 <br>
Users with 6 orders: 2 <br>
Users with 7 orders: 4 <br>
Users with 8 orders: 1 <br>


Query:

<code>
WITH orders_users_tbl AS ( <br>
SELECT  <br>
    USER_GUID, <br>
    COUNT(ORDER_GUID) AS total_orders <br>
FROM dev_db.dbt_janio.stg_postgres__orders <br>
GROUP BY 1 <br>
)
SELECT <br>
    total_orders, <br>
    COUNT(user_guid) as cnt_users <br>
FROM orders_users_tbl <br>
GROUP BY 1 <br>
ORDER BY 1 <br>

</code>


**Question #5: On average, how many unique sessions do we have per hour?** 

On average we have **16.32 sessions**
<code>

WITH unique_session_cnt AS ( <br>
    SELECT <br>
        trunc(created_at_utc, 'hour') AS hourly,<br>
        COUNT(DISTINCT session_guid) AS unique_sessions <br>
    FROM dev_db.dbt_janio.stg_postgres__events <br>
    GROUP BY 1   <br>
) <br>
select <br>
    AVG(unique_sessions) AS avg_unique_sessions <br>
from unique_session_cnt <br>

SELECT * FROM dev_db.dbt_janio.stg_postgres__events

</code>