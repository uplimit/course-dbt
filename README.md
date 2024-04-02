# Analytics engineering with dbt

Template repository for the projects and environment of the course: Analytics engineering with dbt

> Please note that this sets some environment variables so if you create some new terminals please load them again.

## Week 1 Assignment

### Question 1: How many users do we have?
** Answer: 130

```sql
select count(distinct user_id) 
from stg_users
```

## Rest
On average, how many orders do we receive per hour? 7.52
On average, how long does an order take from being placed to being delivered? 3.891
How many users have only made one purchase? Two purchases? Three+ purchases? 25, 28, 71 
On average, how many unique sessions do we have per hour? 16.327



## License
GPL-3.0
