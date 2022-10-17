### Week 1 Project

### 1. What is our user repeat rate?

Our user repeat rate is 0.225.

```
with orders_cohort as (
    select 
        user_id,
        count(distinct order_id) as user_orders
    from DEV_DB.DBT_PLE.STG_ORDERS
    group by 1), 
    
user_bucket as (
    select user_id,
    (user_orders = 1) ::int as has_one_purchases,
    (user_orders = 2) ::int as has_two_purchases,
    (user_orders >= 3) ::int as has_three_purchases
from orders_cohort
)

select
    div0(sum(has_two_purchases), count(distinct user_id)) as repeat_rate
from user_bucket
```


### 2. What are good indicators of a user who will likely purchase again? What about indicators of users who are likely NOT to purchase again? If you had more data, what features would you want to look into to answer this question?

Some good indicators of a user who will likely purchase again would be the number of purchase they have historically (2+ purchases), how fast the orders get delivered (difference of created at time and delivered at time), user who often checks the website, high order value/quantity 

Some good indicators of a user who will NOT likely purchase again would be users that only have orders using promo code with a high discounts, users that have items in cart but never checked out 

If I had more data that contains the following information, it would help answer this question 
- how long items were in the event_type "add to cart"
- how long sessions last/ how long was the user browsing on the site for 
- more demographics data on users (eg. gender, age range, income)


### 3. What assumptions are you making about each model? (i.e. why are you adding each test?)

I assumed the user id to be unique and not null. Also, any user id, address id, sessions id, and timestamp should never be null. Total orders and any order cost should be positive so I added the positive values test.

### 4. Did you find any “bad” data as you added and ran tests on your models? How did you go about either cleaning the data in the dbt model or adjusting your assumptions/tests?

Not really. I did add the unique test to the address id but it failed. I realized this might be because users can ship to various address so that field did not have to be unique.

### 5. Explain how you would ensure these tests are passing regularly and how you would alert stakeholders about bad data getting through.

I plan to run these tests whenever we add new data to the model or do a weekly test 

### 6. dbt snapshots - which orders changed from week 1 to week 2

There are 3 orders that changed from week 1 to week 2 and those orders are now shipped with the estimated delivery on 2/19/2021

