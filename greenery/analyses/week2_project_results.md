--------------------------------------------------------------------------  
What is our user repeat rate? 99/124 = 79.84%
--------------------------------------------------------------------------
-- (Repeat Rate = Users who purchased 2 or more times / users who purchased)
SELECT count_if(order_ct > 1) users_who_purchased_2_or_more_times
    , count_if(order_ct > 0) users_who_purchased_at_least_once
    , ROUND((100*users_who_purchased_2_or_more_times / 
            users_who_purchased_at_least_once),2) || '%' as repeat_rate
FROM user_order_facts
