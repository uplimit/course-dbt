# Week 1 Project:

**Question :**  
How many users do we have?  
  
**Answer :**  
130 unique users  
  
**Query :**  
  
```sql  
SELECT COUNT(DISTINCT(user_id)) AS COUNT
FROM dev_db.dbt_burjack86gmailcom.stg_postgres__users
```
  
---  
  
**Question :**  
On average, how many orders do we receive per hour?  
  
**Answer :**  
On average, we receive approximately 15 orders per hour
  
**Query :**  

```sql
SELECT DISTINCT
    AVG(COUNT(*)) OVER () AS avg_orders_per_hour
FROM
    dev_db.dbt_burjack86gmailcom.stg_postgres__orders
GROUP BY
    EXTRACT(HOUR FROM created_at)
```
  
---  
  
**Question :**    
On average, how long does an order take from being placed to being delivered?  
  
**Answer :**  
On average, it takes almost 4 days (circa 3 days and 22 hours) for an order to be delivered.
  
**Query :**  

```sql
SELECT AVG(DATEDIFF(DAY, created_at, delivered_at)) AS avg_delivery_days
FROM dev_db.dbt_burjack86gmailcom.stg_postgres__orders
WHERE status = 'delivered'
```
  
---  
  
**Question :**  
How many users have only made one purchase? Two purchases? Three+ purchases?  
  
**Answer :** 
Users by number of purchases are as follows:
One purchase = 25  
Two purchases = 28  
Three+ purchases = 71  
  
**Query :**  
  
```sql
WITH agg_purchases AS(
SELECT
    COUNT(DISTINCT(order_id)) AS order_count
    , CASE 
        WHEN order_count = 1 THEN '=1'
        WHEN order_count = 2 THEN '=2'
        WHEN order_count >= 3 THEN '>= 3'
    END AS purchase_cohort
FROM dev_db.dbt_burjack86gmailcom.stg_postgres__orders
GROUP BY user_id
)

SELECT
    purchase_cohort,
    COUNT(order_count) AS order_count
FROM agg_purchases
GROUP BY purchase_cohort
```
  
---  
  
**Question :**    
On average, how many unique sessions do we have per hour?  
  
**Answer :**    
On average, there are almost 40 sessions per hour (39.46).
  
**Query :**  
  
```sql
WITH sessions_hour AS (
SELECT DISTINCT
    EXTRACT(HOUR FROM created_at),
    COUNT(DISTINCT(session_id)) AS sessions_per_hour
FROM dev_db.dbt_burjack86gmailcom.stg_postgres__events
GROUP BY EXTRACT(HOUR FROM created_at)
ORDER BY EXTRACT(HOUR FROM created_at)
)

SELECT 
AVG(sessions_per_hour) AS avg_sessions_per_hour
FROM sessions_hour
```
  