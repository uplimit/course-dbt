# Week 3 Project 

### PART 1

#### 1) What is our overall conversion rate?
62.46% 


```sql 
select view_purchase_conversion_rate as conversion_rate
from dbt_mahelet_f.facts_conversions
```

To calculate this, I updated intermediate model I built in week 2 (name: `int_events_grouped_by_session.sql`; location: `models/marts/product/intermediate`). This model aggeragtes stg_events table at the session-level. I added columns whether or not the session had a page view event, add-to-cart event, and/or purchase event. Then I created a fact model (name: `facts_conversions.sql`, location: `models/marts/product`) to calcuate the different conversion rates that exist across the funnel like page view to add to cart, page view to purchase, add to cart to purchase. 


#### 2) What is our conversion rate by product?

``` sql 
select product_id
, view_purchase_conversion_rate as conversion_rate 
from dbt_mahelet_f.facts_product_conversions
order by 1 asc 
```

product_id	                            | conversion_rate
--------------------------------------- | ----------------
05df0866-1a66-41d8-9ed7-e2bbcddd6a3d	| 45
35550082-a52d-4301-8f06-05b30f6f3616	| 48.89
37e0062f-bd15-4c3e-b272-558a86d90598	| 46.77
4cda01b9-62e2-46c5-830f-b7f262a58fb1	| 34.43
55c6a062-5f4a-4a8b-a8e5-05ea5e6715a3	| 48.39
579f4cd0-1f45-49d2-af55-9ab2b72c3b35	| 51.85
58b575f2-2192-4a53-9d21-df9a0c14fc25	| 39.34
5b50b820-1d0a-4231-9422-75e7f6b0cecf	| 47.46
5ceddd13-cf00-481f-9285-8340ab95d06d	| 49.25
615695d3-8ffd-4850-bcf7-944cf6d3685b	| 49.23
64d39754-03e4-4fa0-b1ea-5f4293315f67	| 47.46
689fb64e-a4a2-45c5-b9f2-480c2155624d	| 53.73
6f3a3072-a24d-4d11-9cef-25b0b5f8a4af	| 41.18
74aeb414-e3dd-4e8a-beef-0fa45225214d	| 55.56
80eda933-749d-4fc6-91d5-613d29eb126f	| 41.89
843b6553-dc6a-4fc4-bceb-02cd39af0168	| 42.65
a88a23ef-679c-4743-b151-dc7722040d8c	| 47.83
b66a7143-c18a-43bb-b5dc-06bb5d1d3160	| 53.97
b86ae24b-6f59-47e8-8adc-b17d88cbd367	| 50.94
bb19d194-e1bd-4358-819e-cd1f1b401c0c	| 42.31
be49171b-9f72-4fc9-bf7a-9a52e259836b	| 51.02
c17e63f7-0d28-4a95-8248-b01ea354840e	| 54.55
c7050c3b-a898-424d-8d98-ab0aaad7bef4	| 45.33
d3e228db-8ca5-42ad-bb0a-2148e876cc59	| 46.43
e18f33a6-b89a-4fbc-82ad-ccba5bb261cc	| 40
e2e78dfc-f25c-4fec-a002-8e280d61a2f2	| 41.27
e5ee99b6-519f-4218-8b41-62f48f59f700	| 40.91
e706ab70-b396-4d30-a6b2-a1ccf3625b52	| 50
e8b6528e-a830-4d03-a027-473b411c7f02	| 39.73
fb0e8be7-5ac4-4a76-a1fa-2cc4bf0b2d80	| 60.94

To calculate this, I created a new intermediate model (name: `int_sessions_grouped_by_product.sql`; location: `models/marts/product/intermediate`) that aggregates page view event, add-to-cart event, and/or purchase event at the product-level. Then I created a fact model (name: `facts_product_conversions.sql`, location: `models/marts/product`) to calcuate the different conversion rates that exist across the funnel like page view to add to cart, page view to purchase, add to cart to purchase. 


### PART 2

We’re getting really excited about dbt macros after learning more about them and want to apply them to improve our dbt project. 

Create a macro to simplify part of a model(s). Think about what would improve the usability or modularity of your code by applying a macro. Large case statements, or blocks of SQL that are often repeated make great candidates. Document the macro(s) using a .yml file in the macros directory.

I created a macro called `calculate_rates`, which takes values in two columns, divides the values, mutliplies the values by 100 and rounds the output to the nearest hundredths. 

I added this macro to my `facts_product_conversions` and `facts_conversions` models. Both are located in the `model/marts/product` folder. 

### PART 3

Post-hook set-up in `dbt_project.yml`

### Part 4 

I installed the dbt_expectations package. I used the test `expect_column_values_to_be_between` on the conversion rate columns in `facts_product_conversions` and `facts_conversions`. 

I set the min and max arguments in the test to be 0 and 100, respectively. If the conversion rates are more than 100 that would let me know that the denominator is greater than the numerator, which is unexpected behavior.  

You can find my implementation of the test in `models/marts/product/product.yml`. 


### PART 5

![DAG](https://github.com/mahelet-fekade/course-dbt/blob/week3/greenery/projects/week_3_dag.png)

