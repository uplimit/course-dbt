What is our user repeat rate?
Approximately 80% of users repeat the purchase.

```with users as(
select user_id, count(distinct order_id) as number_of_orders from dev_db.dbt_juliepanteleevagmailcom.stg_postgres__orders
left join dev_db.dbt_juliepanteleevagmailcom.stg_postgres__users using (user_id)
group by 1), 
cte as (
select 
count(distinct user_id) as users_number,
count(distinct (case when number_of_orders > 0 then user_id else null end)) as number_purchased,
count(distinct (case when number_of_orders > 1 then user_id else null end)) as number_repeated
from users)
select number_repeated/number_purchased
from cte
```



What are good indicators of a user who will likely purchase again? What about indicators of users who are likely NOT to purchase again? If you had more data, what features would you want to look into to answer this question?

Good indicators:
1. User didn't return their order.
2. User has a discount code for the 2nd order.

Bad indicators:
1. Customer support contact.
2. User returned their first order.
3. User left negative review