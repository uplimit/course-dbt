
---
**Week 2 Project**

**(Part 1) Models**

1. What is our user repeat rate?
- Repeat Rate = Users who purchased 2 or more times / users who purchased
- Note this SQL below is not pretty but it works! See cleaner way to create this query in "Lessons learned" below.
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

- There's a lot that could be explored here, but indicators for purchasing again could be:
  - repeat rate (higher chance of buying again and again)
  - number of times visiting a particular product or group of related products
  - usage of promo codes and how that may affect buying patterns
- Indicators to NOT purchase again
  - session time: i.e. short session times (the user bounces quickly off the page)
  - abandoned carts, abandoned funnel journeys


3. Explain the marts models you added. Why did you organize the models in the way you did?

**Core**
- I only created one table here but my philosophy here is to make simple models that will enrich models for the individual business units.
- `int_orders_promos` simply combines the `orders` model with the `promos` model

**Marketing**
- I tried to think of what a marketing department would want out of a data warehouse.
- As an example I created `fct_orders_promos_usage` model that allows easy querying of promo code usage at an order level
- The `int_user_orders` model has a lot of potential for use in 

**Product**
- I did not anything different from Jake's example with the `fct_sessions` model here but I'm stoked about how easy it was to create this.

4. Use the dbt docs to visualize your model DAGs to ensure the model layers make sense

---
**(Part 2) Tests**

1. Add dbt tests into your dbt project on your existing models from Week 1, and new models from the section above
- What assumptions are you making about each model? (i.e. why are you adding each test?)
- Did you find any “bad” data as you added and ran tests on your models? 
- How did you go about either cleaning the data in the dbt model or adjusting your assumptions/tests?
- Apply these changes to your github repo

I did not deep dive into tests this week but I did notice that there were a handful of users who were in the `users` source model but never ordered anything. So I created a test on the `int_user_orders` model to see where `order_id` is `not null`. I think these users could be removed from the users table.

2. Your stakeholders at Greenery want to understand the state of the data each day. 
- Explain how you would ensure these tests are passing regularly and how you would alert stakeholders about bad data getting through.

  - If one of the tests fails, I could alert the source owner somehow via Slack or my company's messaging platform.
  - I want to try using the `--store-failures` flag more extensively next week when running tests.
---
**Useful things I learned this week**
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
```sql
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

- Run tests and store the failures using
```
dbt test --store-failures
```
- [dbt tests web page](https://docs.getdbt.com/docs/building-a-dbt-project/tests)

Reflection
- I'm starting to see how end business users can request special "asks" for information from you, and how you can plan ahead and hopefully anticipate these "asks".
- I found myself renaming conflicting aliases in the intermediate models which made me question my earlier naming decisions i.e. "I had a 'created_at_utc' for both users and orders so I renamed them to 'order_created_at_utc' and 'user_created_at_utc'"
- I discovered that some users are in the user model even if they have never completed an order. I'll investigate this later.