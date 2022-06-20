**WEEK 02 HOMEWORK QUESTIONS**

**(Part 1) Models**

1. What is our user repeat rate? **0.79** 
    - *Repeat Rate = Users who purchased 2 or more times / users who purchased*


```
with repeat_users as (
  select
    user_guid
    , (total_orders >= 2)::int as has_two_plus_purchases
  from dbt_jason_d.fct_user_orders
  where total_orders > 0
)

select sum(has_two_plus_purchases)::float / 
       count(user_guid)::float as repeat_rate
from repeat_users
```

2. What are good indicators of a user who will likely purchase again? What about indicators of users who are likely NOT to purchase again? If you had more data, what features would you want to look into to answer this question?
    - *NOTE: This is a hypothetical question vs. something we can analyze in our Greenery data set. Think about what exploratory analysis you would do to approach this question.*
    - **good indicators might be:**
        - time since last purchase (how often do 'good' clients purchase plants/etc. from us)
        - avg_basket_size (those with bigger baskets may shop more in general)
        - high conversion after viewing site
        - regular visits to site
    - **indicators of not purchasing again:**
        - low spend
        - too much time has passed since last purchase
        - small basket size OR low total spend in general (gift shopper + maybe not a regular client)
        - many sessions/events where they view site but don't convert
        - too much time passed since visiting site

3. Explain the marts models you added. Why did you organize the models in the way you did?
    - *Paste in an image of your DAG from the docs. These commands will help you see the full DAG
        - $ dbt docs generate 
        - $ dbt docs serve --no-browser  

    -- **see image in slack** 

    - **pretty new at data-modeling at scale. always been pretty good at thinking through tables in general but doing it with the DAG in mind along w/organization of the staging/marts, is totally different. I honestly followed the layout provided for the most part and did my best to start with the end in mind (table/query/etc)

**(Part 2) Tests**

1. What assumptions are you making about each model? (i.e. why are you adding each test?)
    - **int_order_items_agg:**
        - item count is positive b/c orders should at least 1 or more items included
        - order_guid is not null and is unique b/c this table is aggregated at order level
    - **int_order_promos_joined:**
        - basic tests here to ensure order_guid is unique, not null, and that orders have positive sales values.
    - **fct_user_orders:**
        - ensure user_guid is not null and is unique
        - total_items is positive. also had this as not null BUT realized some users have NO orders so those should be null (so removed that one)
        - setup a macro to test that 'last_order_date' is before current_date

2. Did you find any “bad” data as you added and ran tests on your models? How did you go about either cleaning the data in the dbt model or adjusting your assumptions/tests?
    - **nothing quite yet**. just the callout that some users have not made purchases yet but that's not bad data.

3. Apply these changes to your github repo
    - **done**

4. Your stakeholders at Greenery want to understand the state of the data each day. Explain how you would ensure these tests are passing regularly and how you would alert stakeholders about bad data getting through.
    - **maybe have an aggreement in place that says assume data is good unless notified otherwise. then, have alerts in place for more serious issues that need to be communicated to stakeholders if our team cannot resolve immediately.**