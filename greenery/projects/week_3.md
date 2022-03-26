# Week 3 Project 

### PART 1

NOTE: conversion rate is defined as the # of unique sessions with a purchase event / total number of unique sessions. Conversion rate by product is defined as the # of unique sessions with a purchase event of that product / total number of unique sessions that viewed that product

#### 1) What is our overall conversion rate?
62.46% 


```sql 
select view_purchase_conversion_rate as conversion_rate
from dbt_mahelet_f.facts_conversions
```


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


### PART 2

We’re getting really excited about dbt macros after learning more about them and want to apply them to improve our dbt project. 

Create a macro to simplify part of a model(s). Think about what would improve the usability or modularity of your code by applying a macro. Large case statements, or blocks of SQL that are often repeated make great candidates. Document the macro(s) using a .yml file in the macros directory.

marco: calculate_rates 

Looking at the code I wrote for Part 1, 

page view --> adding to cart, adding to cart --> purchasing, page view --> purcahases 

used in 
facts_product_conversions (location: model/marts/product)
facts_conversions (location: model/marts/product) 

### PART 3

We’re starting to think about granting permissions to our dbt models in our postgres database so that other roles can have access to them.

Add a post hook to your project to apply grants to the role “reporting”. Create reporting role first by running CREATE ROLE reporting in your database instance.

NOTE: After you create the role you still need to grant it usage access on your schema dbt_<firstname>_<lastinitial> (what you set in your profiles.yml in week 1) which can be done using on-run-end

HINT: you can use the grant macro example from this week and make any necessary changes for postgres syntax

