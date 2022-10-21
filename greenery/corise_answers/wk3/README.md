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
Macro order_revenue is used in tbl_product_metrics and tbl_order_ledger
The note in the course materials says "start here" for a specific formula
    That specific formula doesn't make a lot of sense in this representation of the data
    Because event types per session are aggregated once in the transformation
I have chosen to follow the conflicting instructions to think about what would improve the
    Usability/modularity of the code


### Hooks
See the practice hook added to `stg_address.sql`
I couldn't think of a useful hook, although the GRANT SELECT idea originally in the
    instructions could have been good (especially if the config option `grant` didn't exist)
When and how to use hooks was something I was hoping to get out of this class,
    and it's disappointing to still not have any practical examples of when it's
    worthwhile to add something as a post hook


### Packages
Added a package and usage one of the macros.
Similarly felt like more direction would have created a better learning environment
    (perhaps a goal that's hard to code, but solved by a certain package)
Reading through package contents is a good skill
    but in real life is more of a hunt for a specific functionality


### DAG changes
Skipped.  There were no DAG changes with the changes made here.
This too seems like a place where more could be learned with greater structure.


### Snapshots
3 orders gained tracking IDs, shipping service, estimated delivery at, and status to shipped
```SQL
SELECT
    *
FROM snapshot_orders
WHERE order_id IN (
    SELECT order_id
    FROM snapshot_orders
    WHERE dbt_valid_to > '2022-10-17'
)
ORDER BY order_id, dbt_valid_to DESC
```

Heads up, this is saved in the course git repository as `delivery_update.sql` and  `delivery_update.sh`
Would appreciate a little more professionalism

