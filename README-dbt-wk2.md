# dbt week2 project 

## Outline 

### Models and Testing 

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

WITH user_orders AS ( 
    SELECT 
      user_guid,
      count(distinct(order_guid)) as orders_placed -- 3 statuses. Break out if need to see patterns 
    FROM 
        dbt_heidi_s.stg_greenery__orders
    GROUP BY 
        user_guid
  )

  SELECT 
    orders_placed
    ,count(orders_placed)
  FROM 
    user_orders
  GROUP BY orders_placed
  ORDER by orders_placed
;

-- Answer: rolled up for all orders placed with 1 or more purchases
1       25
2       28
3       34
4       20
5       10
6        2
7        4
8        1

```

```
- Q2:   What are good indicators of a user who will likely purchase again? 
        What about indicators of users who are likely NOT to purchase again? 
        If you had more data, what features would you want to look into to answer this question?
        NOTE: This is a hypothetical question vs. something we can analyze in our Greenery data set. Think about what exploratory analysis you would do to approach this question.
```



