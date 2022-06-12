**WEEK 01 HOMEWORK QUESTIONS**

1. How many users do we have? **130 users**
```
select count(distinct user_id) from dbt_jason_d.stg_public__users;
```

On average, how many orders do we receive per hour?

On average, how long does an order take from being placed to being delivered?

How many users have only made one purchase? Two purchases? Three+ purchases?

Note: you should consider a purchase to be a single order. In other words, if a user places one order for 3 products, they are considered to have made 1 purchase.

On average, how many unique sessions do we have per hour?