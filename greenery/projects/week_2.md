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

Indicators of a user who will likely purchase again: 
* going back to the website and putting items in their shopping carts 
* already an email subscriber or follows you on social media 

Indicators of users who are likely NOT to purchase again
* if there were issues with the delivery (ex. someone got the wrong item, it took a long time to deliver someone's items after they purchased an item  )

What features would you want to look into to answer this question
* how people ended-up on the website (eg, did they click a link in an email, a digital ad, insragram story, etc) 
* 
*

### Q3: Explain the marts models you added. Why did you organize the models in the way you did?

--- agrregate models group by transformation from one unit of analysis to anotehr happened in intermediate models 


##### Core 
-- how much money are we making per day 
-- user data (add in how many past orders, first order, last order)

###### Intermediate models 

###### Dimension/fact models

##### Marketing
--- who is adding items to cart and hasn't checked out yet (space to nudge them via ads)
--- have they ever used a promo code 

###### Intermediate models 

###### Dimension/fact models


##### Product

###### Intermediate models 

###### Dimension/fact models
