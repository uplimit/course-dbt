Welcome to your new dbt project!

### Using the starter project

Try running the following commands:
- dbt run
- dbt test


### Resources:
- Learn more about dbt [in the docs](https://docs.getdbt.com/docs/introduction)
- Check out [Discourse](https://discourse.getdbt.com/) for commonly asked questions and answers
- Join the [chat](https://community.getdbt.com/) on Slack for live discussions and support
- Find [dbt events](https://events.getdbt.com) near you
- Check out [the blog](https://blog.getdbt.com/) for the latest news on dbt's development and best practices

### Week 1 Project 
- How many users do we have? 130 unique users
- On average, how many orders do we receive per hour? 7.52 per hour
- On average, how long does an order take from being placed to being delivered? ~3.89 days
- How many users have only made one purchase? 25 Two purchases? 28 Three+ purchases? 71
ORDER_COUNT	CUSTOMER_COUNT
1	25
2	28
3	34
4	20
5	10
6	2
7	4
8	1
Note: you should consider a purchase to be a single order. In other words, if a user places one order for 3 products, they are considered to have made 1 purchase.

- On average, how many unique sessions do we have per hour? ~16.3 unique sessions per hour