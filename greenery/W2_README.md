
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
FROM dbt_jimmy_l.stg_orders
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
SELECT 
SUM(orders_per_category) AS total_orders
FROM orders_per_cat;
```

2. What are good indicators of a user who will likely purchase again? What about indicators of users who are likely NOT to purchase again? 
- If you had more data, what features would you want to look into to answer this question?
- NOTE: This is a hypothetical question vs. something we can analyze in our Greenery data set. 
- Think about what exploratory analysis you would do to approach this question.

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

- To generate a full DAG in dbt
```
dbt docs generate
dbt docs serve --no-browser
```
- [Using multiple CTEs](https://www.databasejournal.com/ms-sql/tips-for-using-common-table-expressions/#:~:text=The%20second%20CTE%20is%20defined,SELECT%20statement%20references%20each%20CTE.)