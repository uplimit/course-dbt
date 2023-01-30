Welcome to your new dbt project!

### Week 3 Answers
Queries to answer all questions from this week and previous weeks can be found in the `analyses/` folder.

**What is our conversion rate?**  
Query to generate answers: 
```
with sessions as (

    select
        *
    from
        {{ ref('fact_sessions') }}

)

select
    count_if(session_result = 'order_placed') as order_sessions,
    count_if(session_result <> 'order_shipped') as total_sessions,
    round(order_sessions / total_sessions, 2) as conversion_rate
from
sessions
```
Result: 62.5%

**What is our conversion rate by product?**  
Query to generate answers:
```
with product_sessions as (

    select
        *
    from
        {{ ref('fact_product_sessions') }}

)

select 
    product_name,
    count_if(event_type='checkout') as checkout_sessions,
    count(session_id) as total_sessions,
    round(checkout_sessions / total_sessions, 2) as conversion_rate
from
    fact_product_sessions
group by 1
```


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
