
---
**Week 2 Project**

***(Part 1) Models ***

1. What is our user repeat rate?
- Repeat Rate = Users who purchased 2 or more times / users who purchased

```sql
WITH 
-- First CTE 
number_of_user_orders AS( 
SELECT 
  CASE 
    WHEN COUNT(user_id) = 1 THEN '1 order'
    WHEN COUNT(user_id) = 2 THEN '2 orders'
    WHEN COUNT(user_id) >= 3 THEN '3 or more orders' 
  END AS num_orders
FROM dbt_jimmy_l.stg_greenery__orders
GROUP BY user_id
)
,
-- Second CTE
orders_per_cat AS(
SELECT 
  num_orders, 
  COUNT(num_orders) AS orders_per_category
FROM number_of_user_orders
GROUP BY num_orders
ORDER BY num_orders
)
,
-- Third CTE
proportion AS(
SELECT 
  num_orders,
  orders_per_category,
  orders_per_category/(SELECT SUM(orders_per_category) FROM orders_per_cat) AS proportion
FROM orders_per_cat
)
SELECT ROUND(SUM(proportion),3)*100 AS repeat_customers_pct
FROM proportion
WHERE num_orders = '2 orders' OR num_orders ='3 or more orders';
```

2. What are good indicators of a user who will likely purchase again? What about indicators of users who are likely NOT to purchase again? 
- If you had more data, what features would you want to look into to answer this question?
- NOTE: This is a hypothetical question vs. something we can analyze in our Greenery data set. 
- Think about what exploratory analysis you would do to approach this question.

**Good indicators of likely to purchase again?**
- Maybe this person is on the edge of buying something.
- Maybe this person is checking if there is a sale for something.

**Core**
- fact_orders table + promos
- dim_products table
- dim_users
- How can I build off of the core?
- Naming... __core_product_views???

**Marketing**
- The marketing mart could contain a model like user_order_facts which contains order information at the user level.
- For marketing mart we might want to dig into users — when was their first order? Last order? 
- How many orders have they made? Total spend? We might want to dig into our biggest customers and look at trends. 
- As a simple but important model, we can connect user and order data to make querying data about a user easier for stakeholders.

**Product**
- The product mart could contain a model like fact_page_views which contains all page view events from greenery’s events data
- We might we want to know how different products perform. 
  - What are daily page views by product? 
  - Daily orders by product? 
  - What’s getting a lot of traffic, but maybe not converting into purchases?

3. Explain the marts models you added. Why did you organize the models in the way you did?

4. Use the dbt docs to visualize your model DAGs to ensure the model layers make sense
- Paste an image of your DAG from the docs.

***(Part 2) Tests ***

1. Add dbt tests into your dbt project on your existing models from Week 1, and new models from the section above
- What assumptions are you making about each model? (i.e. why are you adding each test?)
- Did you find any “bad” data as you added and ran tests on your models? 
- How did you go about either cleaning the data in the dbt model or adjusting your assumptions/tests?
- Apply these changes to your github repo

2. Your stakeholders at Greenery want to understand the state of the data each day. 
- Explain how you would ensure these tests are passing regularly and how you would alert stakeholders about bad data getting through.

---
**Useful things I learned in this project**
- Why might we want **different** descriptions for tables in **source** and the **schema**?
  - The description in **source** should describe the source data
  - The description in the **schema** should describe the data you model, i.e. what transformations you did
- To generate a full DAG in dbt
```
dbt docs generate
dbt docs serve --no-browser
```

- [Using multiple CTEs](https://www.databasejournal.com/ms-sql/tips-for-using-common-table-expressions/#:~:text=The%20second%20CTE%20is%20defined,SELECT%20statement%20references%20each%20CTE.)
- The difference between `date_trunc` and `date_part`. From Sourabh
```sql
SELECT
  date_trunc('day', timestamp '2002-09-17 19:27:45') AS a,
  date_trunc('day', timestamp '2002-09-17 09:57:45') AS a,
  date_part('day', timestamp '2002-09-17 19:27:45') AS c,
  date_part('day', timestamp '2002-09-17 09:57:45') AS d
;
```
- [Difference between ID's and GUID's](https://blog.codinghorror.com/primary-keys-ids-versus-guids/)

- Way to create a boolean for different conditions
```
WITH orders_cohort AS (
  SELECT
    user_id
    , COUNT(DISTINCT order_id) AS user_orders
    FROM dbt.dbt_jimmy_l.stg_greenery__orders
    GROUP BY 1
)
-- Put the users into buckets with a 0 and 1 flag
-- ::int casts the column as type int
  SELECT
    user_id
    , (user_orders = 1)::int AS has_one_purchases
    , (user_orders >= 2)::int AS has_two_purchases
    , (user_orders >= 3)::int AS has_three_plus_purchases
  FROM orders_cohort
```

- When running a single dbt model you don't need to include the .sql file extension
```
-- This is correct
dbt run -m int_session_events_agg

-- This is incorrect
dbt run -m int_session_events_agg.sql
```