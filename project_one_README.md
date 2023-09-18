## How many users do we have?
A: 130
``` 
SELECT COUNT ( DISTINCT USER_UUID) 
FROM DEV_DB.DBT_JHUANDERSONMACIASGMAILCOM.STG_USERS
```

## On average, how many orders do we receive per hour?

A: 7.520833
``` 
WITH ORDERS_COUNT_PER_HOUR AS (
    SELECT
      TO_VARIANT(DATE_TRUNC('HOUR', order_created_at)) AS date_hour_group,
      COUNT(ORDER_UUID) AS count
    FROM
      DEV_DB.DBT_JHUANDERSONMACIASGMAILCOM.STG_ORDERS
    GROUP BY
      date_hour_group
)
SELECT AVG(count)
FROM ORDERS_COUNT_PER_HOUR
```

## On average, how long does an order take from being placed to being delivered?
A: 93.403279 Hours
```
SELECT
    AVG(DATEDIFF(HOUR, order_created_at, delivered_at)) AS average_time_difference_seconds
FROM
  DEV_DB.DBT_JHUANDERSONMACIASGMAILCOM.STG_ORDERS
where delivered_at is not NULL
```

## How many users have only made one purchase? Two purchases? Three+ purchases?

A:

NUMBER_OF_ORDERS_GROUP  | NUMBER_OF_USER_WITH_ORDERS
------------- | -------------
1 order  | 25
2 order | 28
3+ orders | 71

```
WITH ORDER_COUNT AS (
    SELECT
        COUNT(ORDER_UUID) AS ct,  user_uuid
    FROM
      DEV_DB.DBT_JHUANDERSONMACIASGMAILCOM.STG_ORDERS
    GROUP BY user_uuid
)

SELECT 
    CASE WHEN CT = 1 THEN '1 order' 
    WHEN CT = 2 THEN '2 order'
    WHEN CT >= 3 THEN '3+ orders' END as number_of_orders_group, 
    COUNT(USER_UUID) AS number_of_user_with_orders
FROM ORDER_COUNT
GROUP BY number_of_orders_group
ORDER BY number_of_orders_group
```

Note: you should consider a purchase to be a single order. In other words, if a user places one order for 3 products, they are considered to have made 1 purchase.

## On average, how many unique sessions do we have per hour?
A: 16.327586
```
WITH SESSION_COUNT_PER_HOUR AS (
    SELECT
      TO_VARIANT(DATE_TRUNC('HOUR', WEB_EVENT_CREATED_AT)) AS date_hour_group,
      COUNT(DISTINCT SESSION_UUID) AS count
    FROM
        DEV_DB.DBT_JHUANDERSONMACIASGMAILCOM.STG_WEB_EVENTS
    GROUP BY
      date_hour_group
)
SELECT AVG(count)
FROM SESSION_COUNT_PER_HOUR
```