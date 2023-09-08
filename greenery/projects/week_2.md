# Week 2 Project 

## (Part 1) Models 

### Q1. What is our user repeat rate?
 79.83% 
``` sql
-- Create CTE to calcuate for each user, how many orders have they made
with user_order as (

select 
  user_id
  , count(distinct order_id) as num_orders 
from dbt_mahelet_f.stg_orders 
group by 1
)

-- calculate number of people who have made any purchase and 2+ purchases 
, calc as (
select 
  SUM(case 
    when num_orders >= 2 then 1 
    ELSE NULL END) as two_plus 
  , COUNT(DISTINCT user_id) as total 
from user_order 
)

select (two_plus::float /total::float) * 100 as user_repeat_rate
from calc 
``` 

### Q2. What are good indicators of a user who will likely purchase again? What about indicators of users who are likely NOT to purchase again? If you had more data, what features would you want to look into to answer this question?

Indicators of a user who will likely or likely NOT to purchase again
* used a discount code  
* email subscriber or follows you on social media 
* if there were issues with the delivery (ex. someone got the wrong item, it took a long time to deliver someone's items after they purchased an item  )

What features would you want to look into to answer this question
* how people ended-up on the website (eg, did they click a link in an email, a digital ad, insta story, etc) 
* reviews 


### Q3: Explain the marts models you added. Why did you organize the models in the way you did?

##### Marketing
I didn't finish this, but I was thinking building intermediate and dim/facts models to figure out who is going to product pages and items in carts and haven't checkout yet. With this information, the marketing team can target those users via social media to nudge users to buy the item. I would create a int model using stg_events table to figure out who is going to product pages and items in carts and haven't checkout yet. Then create a user-level dim model using the int model and stg_addresses. I would use stg_addresses to help with the social media targeting. 



## (Part 2) Tests 

### Q1. What assumptions are you making about each model? (i.e. why are you adding each test?)
* unique ID in each table is unique 
* unique ID in eac table doesn't have any NULLs 
* for tables that can be merged together, the merging fields have the same values across tables (eg, in stg_users every address_id exists in stg_addresses and vice versa)

### Q2. Did you find any “bad” data as you added and ran tests on your models? How did you go about either cleaning the data in the dbt model or adjusting your assumptions/tests?
Issue with merging fields between tables. Some tables would have different id values than others 
- stg_addresses and stg_orders
- stg users and stg_events 
- stg_users and  stg_orders 

Since the staging tables are 1:1 with the source data, I don't think it makes sense to clean-up the data in the dbt model. Instead, I would investigate why the source data issue and figure out what's going on with the syncs. 

### Q3. Your stakeholders at Greenery want to understand the state of the data each day. Explain how you would ensure these tests are passing regularly and how you would alert stakeholders about bad data getting through.

Set-up scheduled dbt runs every x hours, after `dbt run` is run and run `dbt test`. If there are errors that are uncovered when `dbt test` is run, a message would be posted in a slack channel and tag the analytics engineer, so they can investigate the issue. 