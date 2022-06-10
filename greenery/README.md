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

1. How many users do we have?
SELECT COUNT(DISTINCT(user_id)) FROM dbt_jimmy_l.stg_users;
- We have 130 users.
- Method: We calculatae the distinct number of users on the platform.

2. On average, how many orders do we receive per hour?
WITH hourly_orders AS (
  SELECT COUNT(order_id) as order_per_hour, date_trunc('hour', created_at) as utc_trunc
  from dbt_jimmy_l.stg_orders
  group by utc_trunc)

SELECT AVG(order_per_hour)
FROM hourly_orders;
- On average, we receive about 7.52 orders per hour.
- Method: Calculate the total orders per hour. Then, take the average of the total orders per hour.

3. On average, how long does an order take from being placed to being delivered?
- Use tables stg_orders

4. How many users have only made one purchase? Two purchases? Three+ purchases?

5. On average, how many unique sessions do we have per hour?
- Use the events table

