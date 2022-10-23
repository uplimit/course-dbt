## Part 1. Create new models to answer the first two questions 
_What is our overall conversion rate?_ 
0.007
I think I am doing something wrong here, I am not sure if the aggregation I am looking at is correct.
```sql
select count(has_converted), count(total_session_count),sum(has_converted)/ sum(total_session_count) 
from DEV_DB.DBT_ANNBARD12.DIM_USERS
```

_What is our conversion rate by product?_

The conversion rate by product can be found in the DIM_PRODUCTS TABLE in the product mart

```sql
select distinct product_name, conversion_rate
from DEV_DB.DBT_ANNBARD12.DIM_PRODUCTS
```

## Part 2: We’re getting really excited about dbt macros after learning more about them and want to apply them to improve our dbt project. 

I created the get_event_type macro in the macros folder that I use in the int_product_events and int_session_events models. This reduced some space used in my code and made the macro reusable in multiple models.

## Part 3: We’re starting to think about granting permissions to our dbt models in our snowflake database so that other roles can have access to them.

I added reporting role permissions into dbt_project.yml.

```
models:
  greenery:
    # Config indicated by + and applies to all files under models/example/
    example:
      +materialized: view
      marts:  
        +post-hook: "GRANT SELECT ON {{ this }} TO ROLE reporting;"
```

## Part 4:  After learning about dbt packages, we want to try one out and apply some macros or tests.

I used dbt-labs/codegen to generate my .yml files automaticallly and quickly

## Part 5. dbt Snapshots

The following orders have been updated from week 2 to week 3:

8385cfcd-2b3f-443a-a676-9756f7eb5404
e24985f3-2fb3-456e-a1aa-aaf88f490d70
5741e351-3124-4de7-9dff-01a448e7dfd4