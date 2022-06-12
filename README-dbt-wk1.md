# dbt week1 project 

## Outline 
Create the project greenery, models, schema, and profile to load the transformed data into the Postgres dbt_heidi_s schema along side the original data source in publich schema 

Goals for the week 
1. Understand the dbt Cloud project structure 
2. Understand the location of the source data (Postgres public) and the transformed data (Postgres dbt_heidi_s) and the driver dbt-project.yml file that defines those values
3. Learn the dbt init, debug, compile, run, and test commands for what they do after creating models  

## Directory Structure 
Week 1 high project directory structure listed below (models is the main directory for Wk1 project)

```
ls -R | grep ":$" | sed -e 's/:$//' -e 's/[^-][^\/]*\//--/g' -e 's/^/   /' -e 's/-/|/'
   .
   |-greenery
   |---analyses
   |---dbt_packages
   |-----dbt_utils
   |-------etc
   |-------integration_tests
   |---------ci
   |---------data
   |-----------cross_db
   |-----------datetime
   |-----------etc
   |-----------geo
   |-----------materializations
   |-----------schema_tests
   |-----------sql
   |-----------web
   |---------macros
   |---------models
   |-----------cross_db_utils
   |-----------datetime
   |-----------geo
   |-----------materializations
   |-----------schema_tests
   |-----------sql
   |-----------web
   |---------tests
   |-----------jinja_helpers
   |-----------sql
   |-------macros
   |---------cross_db_utils
   |---------jinja_helpers
   |---------materializations
   |---------schema_tests
   |---------sql
   |---------web
   |---logs
   |---macros
   |---models
   |-----example
   |-----staging
   |-------greenery
   |---------logs
   |-------tutorial
   |---seeds
   |---snapshots
   |---target
   |-----compiled
   |-------greenery
   |---------models
   |-----------example
   |-------------schema.yml
   |-----------staging
   |-------------greenery
   |---------------schema_stg_greenery.yml
   |---------------src_stg_greenery.yml
   |---------------stg_greenery__addresses.sql
   |---------------stg_greenery__events.sql
   |---------------stg_greenery__orders.sql
   |---------------stg_greenery__order_items.sql
   |---------------stg_greenery__products.sql
   |---------------stg_greenery__promos.sql
   |---------------stg_greenery__users.sql 
   |-----run
   |-------greenery
   |---------models
   |-----------example
   |-------------schema.yml
   |-----------staging
   |-------------greenery
   |---------------schema_stg_greenery.yml
   |---------seeds
   |---tests
   |-logs
```

## Questions for Week1 from data 
- Q1:    How many users do we have?
```
-- Determine there are no duplicate guids 
SELECT 
    user_guid 
    , count(*)
FROM  
    dbt_heidi_s.stg_greenery__users
GROUP BY 
    user_guid 
HAVING count(*) > 1;

-- Count of number of users 
SELECT 
    count(user_guid) 
FROM 
    dbt_heidi_s.stg_greenery__users
;

-- Answer - 130 

```


- Q2:    On average, how many orders do we receive per hour?
```
-- Determine that there are no duplicate guids 
SELECT order_guid, count(*)
FROM  
    dbt_heidi_s.stg_greenery__orders
GROUP BY 
    order_guid 
HAVING count(*) > 1;


-- date_trunc works oddly 
-- date_part focuses on the hour
-- a between could narrow it down timestamp wise per day when comparing now to now minus interval 1 day

-- Count of orders per hour 
SELECT    
  date_part('hour', created_at_utc) as hourly_part, -- ex: 23
  count(order_guid) as orders_per_hour   
FROM 
    dbt_heidi_s.stg_greenery__orders
GROUP BY 
    hourly_part
; 

WITH avg_orders_by_hour AS ( 
    SELECT    
        date_part('hour', created_at_utc) as hourly_part, -- ex: 23
        count(order_guid) as orders_per_hour   
    FROM 
        dbt_heidi_s.stg_greenery__orders
    GROUP BY 
        hourly_part
  )

  SELECT 
    round(avg(abs(orders_per_hour)),2) 
  FROM 
    avg_orders_by_hour 
; 

-- Answer: 15.04 

```
- Q3:    On average, how long does an order take from being placed to being delivered?
```
WITH order_delivery_time AS ( 
    SELECT 
        date_part('hour', created_at_utc) as hour_created
      , date_part('hour', delivered_at_utc) as hour_delivered
      , age(delivered_at_utc,created_at_utc) as delivery_time
    FROM 
        dbt_heidi_s.stg_greenery__orders
    WHERE 
        order_status = 'delivered'
    )
    SELECT 
        avg(delivery_time) 
    FROM 
        order_delivery_time
;

-- Answer: 3 days 21:24:11.803279

```
- Q4:    How many users have only made one purchase? Two purchases? Three+ purchases? Note: you should consider a purchase to be a single order. In other words, if a user places one order for 3 products, they are considered to have made 1 purchase.
```
-- Note: 
-- you should consider a purchase to be a single order. 
-- In other words, 
-- if a user places one order for 3 products, 
-- they are considered to have made 1 purchase.

-- Three statuses: shipped, preparing, delivered 
-- ---------------------------------------------

/*

This appears to not have duplicates and might be worth joining to later 
for the auto filter of package_shipped 

SELECT 
  * 
FROM 
    dbt_heidi_s.stg_greenery__events 
WHERE 
    order_id_guid is not null 
AND 
    event_type ='package_shipped'

*/

-- Find 1 order simple way 
SELECT 
      user_guid,
      count(distinct(order_guid)) as orders_placed -- 3 statuses. Break out if need to see patterns 
    FROM 
        dbt_heidi_s.stg_greenery__orders
    GROUP BY 
        user_guid
    HAVING count(distinct(order_guid)) = 1

; 

-- Answer: 25 orders placed with 1 purchase 

-- Find orders 2, 3 or more simple way 
SELECT 
      user_guid,
      count(distinct(order_guid)) as orders_placed -- 3 statuses. Break out if need to see patterns 
    FROM 
        dbt_heidi_s.stg_greenery__orders
    GROUP BY 
        user_guid
    HAVING count(distinct(order_guid)) > 2

; 

-- Answer: 71 orders placed with 2 or more purchases

WITH user_orders AS ( 
    SELECT 
      user_guid,
      count(distinct(order_guid)) as orders_placed -- 3 statuses. Break out if need to see patterns 
    FROM 
        dbt_heidi_s.stg_greenery__orders
    GROUP BY 
        user_guid
  )

  SELECT 
    orders_placed
    ,count(orders_placed)
  FROM 
    user_orders
  GROUP BY orders_placed
  ORDER by orders_placed
;

-- Answer: rolled up for all orders placed with 1 or more purchases
1       25
2       28
3       34
4       20
5       10
6        2
7        4
8        1

```
- Q5:    On average, how many unique sessions do we have per hour?
```
SELECT 
    session_id_guid 
    , count(*)
FROM  
    dbt_heidi_s.stg_greenery__events
GROUP BY 
    session_id_guid 
HAVING count(*) > 1;
-- this does have duplicates 


WITH  sessions_per_hour AS (
    SELECT 
      date_part('hour', created_at_utc) as hourly_part,
      count(distinct(session_id_guid)) as sessions
    FROM 
        dbt_heidi_s.stg_greenery__events 
    GROUP BY 
        hourly_part 
    )
    SELECT 
        round(avg(sessions),2) 
    FROM 
        sessions_per_hour
;

-- Answer: 39.46

```


