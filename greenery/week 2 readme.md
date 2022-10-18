1: What is our user repeat rate?
Answer: 79.8%
        select
            count(distinct case when order_count >= 2 then user_guid end) as two_or_more,
            count(distinct case when order_count >= 1 then user_guid end) as has_ordered,
            two_or_more/has_ordered
        from dev_db.dbt_bavery.user_order_fact

2:What are good indicators of a user who will likely purchase again? What about indicators of users who are likely NOT to purchase again? If you had more data, what features would you want to look into to answer this question?

Answer: 
Likely purchase again: active on our site, have frequently purchased, hav
Likely to not purchase again: haven't purchased for a while
If i had more data I would want to look at what retention behavior there is for different products, what marketing channel they came in through, what retention is based off of marketing efforts, etc

3: Explain the marts models you added. Why did you organize the models in the way you did?

Answer: I started with fact orders and then worked from there. I brought in some of the raw data from some of my source table for the fact orders table and then i referenced the orders table on some of my other tables to get info on order freqency and things like that

4: Which orders changed from week 1 to week 2? 

Answer: 3 orders changed from preparing to shipped

            select order_guid,
                status,
                dbt_valid_from,
                dbt_valid_to,
                rank() over (partition by order_guid order by dbt_valid_from) as row_rank
            from dev_db.dbt_bavery.orders_ss
            qualify count(*) over (partition by order_guid) > 1