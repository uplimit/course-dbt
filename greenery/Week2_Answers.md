## Week 2 

### Part 1 Models 

*1. What is our user repeat rate?*

 **Answer:**
 
 79.84%

Query:
```ruby
WITH user_purchasing AS
(
SELECT 
SUM(CASE WHEN fct_user_orders.total_number_of_orders = 0 THEN 0 ELSE 1 END) AS total_purchased_users,
SUM(CASE WHEN fct_user_orders.total_number_of_orders >= 2 THEN 1 ELSE 0 END) AS frequent_purchased_users
FROM dbt_zoe_l.fct_user_orders
) 

SELECT 
TO_CHAR((CAST(frequent_purchased_users AS FLOAT) / total_purchased_users)*100, 'fm00D00%') AS repeat_rate
FROM user_purchasing;
```


*2. What are good indicators of a user who will likely purchase again? What about indicators of users who are likely NOT to purchase again? If you had more data, what features would you want to look into to answer this question?*

**Answer:**

* Good indicators: 
  * Promotion used
  * Faster delivery
    * Order arrived faster than the average delivery time
    * Order arrived earlier than the expected delivery time

* Bad indicators:
  * No promotions
  * Slower delivery
    * Order arrived slower than the average delivery time
    * order arrived later than the expected delivery time

* Additional data / questions:
  * Order shipping window: how long did it take to ship the order?
  * Marketing campaigns: who are the targeted customers for promotion discounts? How many customers who received promotions ended up making purchases? Are there any seasonalities in the marketing campaigns? 
  * Product details: what products are commonly purchased together? Are there any upsellings and cross sellings?
  * Customer segmentation: what types of customers are more likely to purchase? (i.e. demographic, purchasing behaviors, location, etc.)



*3. Explain the marts models you added. Why did you organize the models in the way you did?*

**Answer:**

* Core: I added two dim tables (for products and users) and two fact tables (for events and orders) to this folder, as those data contains metrics that are critical to all business departments across the company. Those tables are independent to each other. 
* Marketing: I added one fact table to combine users and orders, which aggregated the total number of orders, total order amount, total discount amount and total number of purchased products on the user level so that we can have an understanding of users purchasing behaviors. 
* Product: I added one intermediate table to aggregate the event data, and one prod fact table to combine the aggregated events with user data. The business logic in the intermediate table can be re-applied to other product analytics. 


*4. Use the dbt docs to visualize your model DAGs to ensure the model layers make sense.*

**DAG:**

![alt text](https://github.com/zoee-liang/course-dbt/blob/main/greenery/DAG_1.png?raw=true)


### Part 2 Tests

*1. What assumptions are you making about each model? (i.e. why are you adding each test?)*

**Answer**

Tests added in staging models: 
* Unique and not_null tests: primary keys
* Relationship test: foreign keys 
* Positive values test: order cost, shipping cost, order total amount, order quantity, product price, discount amount
* Expect column values to be integer type test: order quantity

I haven't added any tests to my marts models yet, given that the transformations I applied so far are not too heavy and the calculations are relatively straightforward. 

*2. Did you find any “bad” data as you added and ran tests on your models? How did you go about either cleaning the data in the dbt model or adjusting your assumptions/tests?*

**Answer**

I haven't found any bad data yet. (But I'm sure after adding more complext business logic, or as the data size grows, there definitely will be.) 

*3. Your stakeholders at Greenery want to understand the state of the data each day. Explain how you would ensure these tests are passing regularly and how you would alert stakeholders about bad data getting through.*

**Answer**

I would schedule dbt jobs to refresh models and run tests on a daily basis. I would then integrate dbt jobs notifications to relevant Slack channels so that stakeholders would get notified immediately after a job failed.  
