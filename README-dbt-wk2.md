# dbt week2 project 

## Outline 

### Models and Testing 

## Part 1 - Models 
Creation of the following directories for marts
Within each marts/greenery project folder, are intermediate models and/or dimension/fact models under each business unit

```
greenery/models/marts/
   |-greenery
   |---core
   |---finance
   |---marketing
   |---product
```

- [ ]  what metrics might be particularly useful for these business units, and build dbt models using greenery’s data

## From class -- homework suggestions 

The marketing mart could contain a model like 
    user_order_facts -- which contains order information at the user level

The product mart could contain a model like 
    fact_page_views -- which contains all page view events from greenery’s events data


## Questions for Week2 from data 

Go back and work to display these 2 for facts 

```
- Q1 Week2 
What is our user repeat rate?
Repeat Rate = Users who purchased 2 or more times / users who purchased

WITH orders_cohort AS (
  SELECT 
    user_guid
    , count(distinct(order_guid)) AS user_orders
  FROM 
    dbt.dbt_heidi_s.stg_greenery__orders
  GROUP BY user_guid
)

, users_bucket AS (
  SELECT 
    user_guid
    , (user_orders = 1)::int AS has_one_purchases
    , (user_orders >= 2)::int AS has_two_purchases
  FROM 
      orders_cohort
)

SELECT 
  (sum(has_two_purchases)::float / count(distinct(user_guid))::float) * 100 AS repeat_rate 
FROM 
    users_bucket

```

```
- Q2:   What are good indicators of a user who will likely purchase again? 
        What about indicators of users who are likely NOT to purchase again? 
        If you had more data, what features would you want to look into to answer this question?
        NOTE: This is a hypothetical question vs. something we can analyze in our Greenery data set. Think about what exploratory analysis you would do to approach this question.
```

Some areas I'd like to explore:

- Understanding what makes a "base" table 
- Seeing what finance would want for costs over time? For businesses it might be a cost per user, or it make be an overhead cost per shipment.
- What would the data start to look like if localized (different locations, different currencies and normalizing that across USD or Euro)

Explain the marts models you added. Why did you organize the models in the way you did?

I tried to mimic the general hierarchial naming I had going with models/staging/greenery with `stg_greenery__${table_name}.sql` for the marts so that the schema YAML file followed the `schema_${business_area}_${project_name}.yml`

For the files under each `marts/${project_name}/${business_area}/` I labelled each type of file by prefix `dim`, `fact`, or `int` for intermediate. 
If there were one or more tables for a dimension then I put the root of the `${table_name}` in the dimension SQL file name. 
For the intermediate files I aggregated data and used `intermediate_${what the table did}_aggregate.sql` 

## Part 2 - Tests

- What assumptions are you making about each model? (i.e. why are you adding each test?)
-- We don't want any nulls
-- We want positive values for anything we want to add to or sum up. 


- Did you find any “bad” data as you added and ran tests on your models? 
-- I noticed there were nulls I had not dealt with. Overall I went back and tuned each staging table so it had more descriptions, more translated nulls where relevant (so that a future case statement to count the values would also end up counting the null values with a placeholder)

- How did you go about either cleaning the data in the dbt model or adjusting your assumptions/tests?
-- What I did not initially get and do now is the idea that if you checked for not null or uniqueness during the staging load - that does not guarentee that the derived tables would not have similar issues. It's more about gating overall and making the assumption to avoid a possible issue. 

- Apply these changes to your github repo
-- Changes were applied in dbt_wk2 branch to show progression from dbt_wk1 branch. 

- Your stakeholders at Greenery want to understand the state of the data each day. Explain how you would ensure these tests are passing regularly and how you would alert stakeholders about bad data getting through.
-- The tests can be run independently of the transformation and alerts can be wrapped in to detect an ERROR and send the error codes that get sent to a table inside the Postgres database. 


