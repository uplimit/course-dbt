### What is our overall conversion rate?

62%
```SQL
USE DATABASE dev_db;
USE SCHEMA dbt_jmanahan;

SELECT ROUND(SUM(sm.checkout_count) / COUNT(1), 4) overall_conversion_rate
FROM tbl_session_metrics sm
;

SELECT 
FROM tbl_product_metrics pm
;
```


### What is our conversion rate by product?

Between 34% and 61%
```SQL
SELECT
    pm.product_id
    , pm.product_name
    , ROUND(
        pm.product_order_count / pm.product_session_count
        , 4
      ) AS product_conversion_rate
FROM tbl_product_metrics pm
;
```


### Why the difference
SKIP.  I'm here to learn the tools and strategies of the trade, not pretend I'm a data analytics stakeholder


### Make a macro