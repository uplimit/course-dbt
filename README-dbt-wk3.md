# dbt week3 project 

## Outline 

### Part 1 

High level conversion rate

```
WITH event_types AS(
SELECT 
    et.session_guid
    , MAX(case when event_type = 'checkout' then 1 else 0 end) as checkouts
    , MAX(case when event_type = 'page_view' then 1 else 0 end) as page_views
FROM 
		dbt_heidi_s.stg_greenery__events et
GROUP BY 
		et.session_guid
)
, agg as (
SELECT
  	sum(event_types.page_views::float as num_page_views
  	, sum(event_types.checkouts)::float as num_event_checkouts
FROM 
  	event_types
)
SELECT 
    num_event_checkouts
    , num_page_views
    , (num_event_checkouts/num_page_views)::numeric(10,2) as high_level_conversion_rate
FROM 
  	agg

  "num_event_checkouts": 361,
  "num_page_views": 578,
  "high_level_conversion_rate": "0.62"

```

Product checkout conversion rate

```
WITH product_page_views AS (
  SELECT events.product_guid
        , products.name
        , COUNT(DISTINCT events.session_guid) AS event_sessions_with_product_view
  FROM 
  		dbt_heidi_s.stg_greenery__events AS events
  LEFT JOIN dbt_heidi_s.stg_greenery__products AS products 
  ON events.product_guid = products.product_guid
  WHERE 
  	events.event_type = 'page_view'
  GROUP BY 		
  		events.product_guid
  		, products.name
),

product_purchases AS (
  SELECT order_items.product_guid
        , COUNT(DISTINCT events.session_guid) AS event_sessions_with_product_purchase
  FROM 
  		dbt_heidi_s.stg_greenery__events AS events
  LEFT JOIN dbt_heidi_s.stg_greenery__order_items AS order_items 
  ON events.order_guid = order_items.order_guid
  WHERE 
  	events.event_type = 'checkout'
  GROUP BY 
  	order_items.product_guid
  )
  
SELECT  product_page_views.product_guid
      , product_page_views.name
      , product_page_views.event_sessions_with_product_view
      , product_purchases.event_sessions_with_product_purchase
      , ROUND(product_purchases.event_sessions_with_product_purchase::numeric / product_page_views.event_sessions_with_product_view::numeric * 100, 2) AS product_conversion_rate
FROM product_page_views
JOIN product_purchases ON product_page_views.product_guid = product_purchases.product_guid
;


[
 {
  "event_sessions_with_product_purchase": 27,
  "event_sessions_with_product_view": 60,
  "name": "Bird of Paradise",
  "product_conversion_rate": "45.00",
  "product_guid": "05df0866-1a66-41d8-9ed7-e2bbcddd6a3d"
 },
 {
  "event_sessions_with_product_purchase": 22,
  "event_sessions_with_product_view": 45,
  "name": "Devil's Ivy",
  "product_conversion_rate": "48.89",
  "product_guid": "35550082-a52d-4301-8f06-05b30f6f3616"
 },
 {
  "event_sessions_with_product_purchase": 29,
  "event_sessions_with_product_view": 62,
  "name": "Dragon Tree",
  "product_conversion_rate": "46.77",
  "product_guid": "37e0062f-bd15-4c3e-b272-558a86d90598"
 },
 {
  "event_sessions_with_product_purchase": 21,
  "event_sessions_with_product_view": 61,
  "name": "Pothos",
  "product_conversion_rate": "34.43",
  "product_guid": "4cda01b9-62e2-46c5-830f-b7f262a58fb1"
 },
 {
  "event_sessions_with_product_purchase": 30,
  "event_sessions_with_product_view": 62,
  "name": "Philodendron",
  "product_conversion_rate": "48.39",
  "product_guid": "55c6a062-5f4a-4a8b-a8e5-05ea5e6715a3"
 },
 {
  "event_sessions_with_product_purchase": 28,
  "event_sessions_with_product_view": 54,
  "name": "Rubber Plant",
  "product_conversion_rate": "51.85",
  "product_guid": "579f4cd0-1f45-49d2-af55-9ab2b72c3b35"
 },
 {
  "event_sessions_with_product_purchase": 24,
  "event_sessions_with_product_view": 61,
  "name": "Angel Wings Begonia",
  "product_conversion_rate": "39.34",
  "product_guid": "58b575f2-2192-4a53-9d21-df9a0c14fc25"
 },
 {
  "event_sessions_with_product_purchase": 28,
  "event_sessions_with_product_view": 59,
  "name": "Pilea Peperomioides",
  "product_conversion_rate": "47.46",
  "product_guid": "5b50b820-1d0a-4231-9422-75e7f6b0cecf"
 },
 {
  "event_sessions_with_product_purchase": 33,
  "event_sessions_with_product_view": 67,
  "name": "Majesty Palm",
  "product_conversion_rate": "49.25",
  "product_guid": "5ceddd13-cf00-481f-9285-8340ab95d06d"
 },
 {
  "event_sessions_with_product_purchase": 32,
  "event_sessions_with_product_view": 65,
  "name": "Aloe Vera",
  "product_conversion_rate": "49.23",
  "product_guid": "615695d3-8ffd-4850-bcf7-944cf6d3685b"
 },
 {
  "event_sessions_with_product_purchase": 28,
  "event_sessions_with_product_view": 59,
  "name": "Spider Plant",
  "product_conversion_rate": "47.46",
  "product_guid": "64d39754-03e4-4fa0-b1ea-5f4293315f67"
 },
 {
  "event_sessions_with_product_purchase": 36,
  "event_sessions_with_product_view": 67,
  "name": "Bamboo",
  "product_conversion_rate": "53.73",
  "product_guid": "689fb64e-a4a2-45c5-b9f2-480c2155624d"
 },
 {
  "event_sessions_with_product_purchase": 21,
  "event_sessions_with_product_view": 51,
  "name": "Alocasia Polly",
  "product_conversion_rate": "41.18",
  "product_guid": "6f3a3072-a24d-4d11-9cef-25b0b5f8a4af"
 },
 {
  "event_sessions_with_product_purchase": 35,
  "event_sessions_with_product_view": 63,
  "name": "Arrow Head",
  "product_conversion_rate": "55.56",
  "product_guid": "74aeb414-e3dd-4e8a-beef-0fa45225214d"
 },
 {
  "event_sessions_with_product_purchase": 31,
  "event_sessions_with_product_view": 74,
  "name": "Pink Anthurium",
  "product_conversion_rate": "41.89",
  "product_guid": "80eda933-749d-4fc6-91d5-613d29eb126f"
 },
 {
  "event_sessions_with_product_purchase": 29,
  "event_sessions_with_product_view": 68,
  "name": "Ficus",
  "product_conversion_rate": "42.65",
  "product_guid": "843b6553-dc6a-4fc4-bceb-02cd39af0168"
 },
 {
  "event_sessions_with_product_purchase": 22,
  "event_sessions_with_product_view": 46,
  "name": "Jade Plant",
  "product_conversion_rate": "47.83",
  "product_guid": "a88a23ef-679c-4743-b151-dc7722040d8c"
 },
 {
  "event_sessions_with_product_purchase": 34,
  "event_sessions_with_product_view": 63,
  "name": "ZZ Plant",
  "product_conversion_rate": "53.97",
  "product_guid": "b66a7143-c18a-43bb-b5dc-06bb5d1d3160"
 },
 {
  "event_sessions_with_product_purchase": 27,
  "event_sessions_with_product_view": 53,
  "name": "Calathea Makoyana",
  "product_conversion_rate": "50.94",
  "product_guid": "b86ae24b-6f59-47e8-8adc-b17d88cbd367"
 },
 {
  "event_sessions_with_product_purchase": 33,
  "event_sessions_with_product_view": 78,
  "name": "Birds Nest Fern",
  "product_conversion_rate": "42.31",
  "product_guid": "bb19d194-e1bd-4358-819e-cd1f1b401c0c"
 },
 {
  "event_sessions_with_product_purchase": 25,
  "event_sessions_with_product_view": 49,
  "name": "Monstera",
  "product_conversion_rate": "51.02",
  "product_guid": "be49171b-9f72-4fc9-bf7a-9a52e259836b"
 },
 {
  "event_sessions_with_product_purchase": 30,
  "event_sessions_with_product_view": 55,
  "name": "Cactus",
  "product_conversion_rate": "54.55",
  "product_guid": "c17e63f7-0d28-4a95-8248-b01ea354840e"
 },
 {
  "event_sessions_with_product_purchase": 34,
  "event_sessions_with_product_view": 75,
  "name": "Orchid",
  "product_conversion_rate": "45.33",
  "product_guid": "c7050c3b-a898-424d-8d98-ab0aaad7bef4"
 },
 {
  "event_sessions_with_product_purchase": 26,
  "event_sessions_with_product_view": 56,
  "name": "Money Tree",
  "product_conversion_rate": "46.43",
  "product_guid": "d3e228db-8ca5-42ad-bb0a-2148e876cc59"
 },
 {
  "event_sessions_with_product_purchase": 28,
  "event_sessions_with_product_view": 70,
  "name": "Ponytail Palm",
  "product_conversion_rate": "40.00",
  "product_guid": "e18f33a6-b89a-4fbc-82ad-ccba5bb261cc"
 },
 {
  "event_sessions_with_product_purchase": 26,
  "event_sessions_with_product_view": 63,
  "name": "Boston Fern",
  "product_conversion_rate": "41.27",
  "product_guid": "e2e78dfc-f25c-4fec-a002-8e280d61a2f2"
 },
 {
  "event_sessions_with_product_purchase": 27,
  "event_sessions_with_product_view": 66,
  "name": "Peace Lily",
  "product_conversion_rate": "40.91",
  "product_guid": "e5ee99b6-519f-4218-8b41-62f48f59f700"
 },
 {
  "event_sessions_with_product_purchase": 28,
  "event_sessions_with_product_view": 56,
  "name": "Fiddle Leaf Fig",
  "product_conversion_rate": "50.00",
  "product_guid": "e706ab70-b396-4d30-a6b2-a1ccf3625b52"
 },
 {
  "event_sessions_with_product_purchase": 29,
  "event_sessions_with_product_view": 73,
  "name": "Snake Plant",
  "product_conversion_rate": "39.73",
  "product_guid": "e8b6528e-a830-4d03-a027-473b411c7f02"
 },
 {
  "event_sessions_with_product_purchase": 39,
  "event_sessions_with_product_view": 64,
  "name": "String of pearls",
  "product_conversion_rate": "60.94",
  "product_guid": "fb0e8be7-5ac4-4a76-a1fa-2cc4bf0b2d80"
 }
]

```

### Part 2 

Working with macros 

```
In working with Jinga templating and run_query to execute case statements dynamically I had the opportunity to clean up and standardize the promo_id (which I renamed promo_description because it was a string and not a guid)  There were some values that had spaces and a dash. This handled the clean up and I lowered all the values to make them consistent. https://github.com/heschmidt04/course-dbt/blob/dbt_wk3/greenery/models/staging/greenery/stg_greenery__orders.sql Then I plugged in the run_query logic into the intermediate model so that the CASE statement would expand the promo_description alias without spaces or weird characters.  ((This is part of the reason I was wondering if one method is more efficient than another i.e. https://github.com/dbt-labs/dbt-utils#get_column_values-source or https://github.com/dbt-labs/dbt-utils#get_query_results_as_dict-source ))

```

### Part 3
Working with post hook 

```
Got the post hook working but the macro blew up. Looking inside information_schema for the grants though did not show they were applied though dbt build said they ran. I need to work on it a bit more.  

```

### Part 4 
```
The macros I have been using are jinga templating for loop for case statements and for forcing a datatype to not change when being used in calculations on the fly. 
Did a dbt run (dry run) of the clean schema macro which is very interesting. I didn't want to foobar my project by dropping my schema before things were due. 
I think I'll have to find a careful way of testing dbt run clean schema in the future. 
```
### Part 5
```
I've simplified the case statements but not in using a macro at the macro directory level. 
That would be where I would want to take it next. 
I am on the fence about using dbt_utils group by just for grouping because I like seeing the columns involved. 
```