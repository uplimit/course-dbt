# Welcome my dbt project!
## These are the answers for the project of week #2!
### (Part 1) Models - Answers

What is our user repeat rate? 79.84%

```with count_of_user_orders as
(select user_id,
      count (distinct (order_id)) as num_of_orders
from dbt."dbt_Marios_A".fact_orders
group by 1),

repeated_user_rate as
(select
sum( case when num_of_orders >= 2 then 1 end) as repeated_users,
sum( case when num_of_orders =  1 then 1 end) as one_time_users,
sum( case when num_of_orders =  0 then 1 end) as never_ordered_users,
sum( case when num_of_orders >  0 then 1 end) as all_users
from count_of_user_orders
)

select 
round(cast(repeated_users as decimal)/cast(all_users as decimal)*100 ,2 ) as repeated_users_rate
from repeated_user_rate
```

What are good indicators of a user who will likely purchase again? What about indicators of users who are likely NOT to purchase again? If you had more data, what features would you want to look into to answer this question?

Good indicators:
- First of all, if the user has repeated an order, he/she would be happy with our services, so the question of this week is a good KPI by itseld.
- We should definately investigate seasonality, here in Greece just before spring everybody is planning the greeneries of the summer (basil, ciliander etc)
- Usage of promotion (if they had one, start promoting our service)

Bad indicators:
- Delivery hickups? was the product deliver on time or not? 
- Has the plant that was bought from our platform has been planted and beared seeds or the planting was unsuccesful?
- The users might think that the price of product we sell is very high and might not purchase from us again.

More data:
- If I could, I would love to see more about financial data of greenery and if it is profitable company or not.
- Definately learn more about our users and/or potential users, demographic data and financial background (who is planting greeneries? the ones using them for food or the ones that have it as a hobby etc)
- Source of orders, from which platform the user found us, facebook/instagram promo or direct url hit from google?

More stakeholders are coming to us for data, which is great! But we need to get some more models created before we can help. Create a marts folder, so we can organize our models, with the following subfolders for business units:

> Core

-dim_order_items : in this table we gathered per order_id and per product_id the quantity of products sold.
-dim_products : this table contains product info such as name, price and investory and also a calculated field of the number of products orders has been created.
-dim_users : in this table, we gathered all the user related info (PII such as first last name) along with the main address information. We should make sure this table is unreachable to other analysts as it contains PII. Finally, we have created a column with the number of times the customer has order from us.
-fact_events : 
-fact_orders : Finally, our main table and the one used more often. It contains order info, with the appropriate timestamps and user info. 

> Marketing

- user_order_facts : this table contains data of users joined with order on a user_id level. Also, per user we calculate the max time of delivery delay, the average number of products ordered and the count of promotion used.

> Product

- user_order_facts : details from events table 


Use the dbt docs to visualize your model DAGs to ensure the model layers make sense


### (Part 2) Tests - Answers

What assumptions are you making about each model? (i.e. why are you adding each test?)

- The main focus was given in all primary keys (ids) not to be null and unique and this was the main tests made in our project
- The secodary focus has give in some other columns to not be null and have a data in order to be used in our analysis
- Last check I did was to have a positive value to each total of each order.

Did you find any “bad” data as you added and ran tests on your models? How did you go about either cleaning the data in the dbt model or adjusting your assumptions/tests?

 - No, I was happy to see all my test to be completed successfully!

Your stakeholders at Greenery want to understand the state of the data each day. Explain how you would ensure these tests are passing regularly and how you would alert stakeholders about bad data getting through.

If you want to ensure these tests that are passing in a regular basis you should definately add the source freshness checks as part of the daily workflow that will schedule this whole workflow. In order to be more specific I would connect these tests even with slack to be notified in almost real time manner. ( I am 99% sure this functionality exists, I need to check :) )