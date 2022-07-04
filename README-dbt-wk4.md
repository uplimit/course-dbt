Week 4 README 

## PART 1: Snapshots


```
-- snapshots/orders_snapshot.sql 

{% snapshot orders_snapshot %}

{# select distinct(status) from orders; shipped, preparing, delivered #}

{{
    config(
      target_schema='snapshots',
      unique_key='order_id',

      strategy='check',
      check_cols=['status'],
    )
}}

SELECT 
    * 
FROM 
  {{ source('greenery', 'orders') }}

{% endsnapshot %}

```

```
gitpod /workspace/course-dbt/greenery $ dbt snapshot
21:11:38  Running with dbt=1.0.2
21:11:38  Found 23 models, 39 tests, 1 snapshot, 0 analyses, 633 macros, 1 operation, 1 seed file, 9 sources, 0 exposures, 0 metrics
21:11:38  
21:11:39  Concurrency: 4 threads (target='dev')
21:11:39  
21:11:39  1 of 1 START snapshot snapshots.orders_snapshot................................. [RUN]
21:11:39  1 of 1 OK snapshotted snapshots.orders_snapshot................................. [SELECT 361 in 0.10s]
21:11:39  
21:11:39  Running 1 on-run-end hook
21:11:39  1 of 1 START hook: greenery.on-run-end.0........................................ [RUN]
21:11:39  1 of 1 OK hook: greenery.on-run-end.0........................................... [GRANT in 0.00s]
21:11:39  
21:11:39  
21:11:39  Finished running 1 snapshot, 1 hook in 0.72s.
21:11:39  
21:11:39  Completed successfully
21:11:39  
21:11:39  Done. PASS=1 WARN=0 ERROR=0 SKIP=0 TOTAL=1

```

```
SELECT 
	* 
FROM snapshots.orders_snapshot
WHERE dbt_valid_to 
IS NOT NULL;

order_id,user_id,promo_id,address_id,created_at,order_cost,shipping_cost,order_total,tracking_id,shipping_service,estimated_delivery_at,delivered_at,status,dbt_scd_id,dbt_updated_at,dbt_valid_from,dbt_valid_to

914b8929-e04a-40f8-86ee-357f2be3a2a2,6aff561d-fbd9-4130-8242-8b9073cc3a03,,b3db1ec9-17b7-4b15-8f04-b2077048f428,2021-02-11 20:54:54,50,6.23,56.23,a807fe66-d8b1-4d38-b409-558fed8bd75f,ups,2021-02-19 10:15:26,,shipped,d2de0c362630484463ffd9dd47102872,2022-06-28 21:11:39,2022-06-28 21:11:39,2022-06-30 00:20:04

05202733-0e17-4726-97c2-0520c024ab85,5951d1d2-614e-4557-a2de-8298a1e4b179,,3a286955-76c1-4b50-b5fc-61e4e4e3be4d,2021-02-11 05:29:28,441,9.71,450.71,8404ed05-0128-4aeb-8ed5-6e44908875c4,ups,2021-02-19 10:15:26,,shipped,22e8f67a0f214cf88ad2ce24ece8485a,2022-06-28 21:11:39,2022-06-28 21:11:39,2022-06-30 00:20:04

939767ac-357a-4bec-91f8-a7b25edd46c9,6cf2751f-d815-4fbc-b04a-245c1301574c,,965dbeea-a6d5-467d-9683-914b744ad1ef,2021-02-10 07:25:48,243.8,8.55,252.35,0a1177bd-5a6d-421b-a13d-11617ef68143,ups,2021-02-19 10:15:26,,shipped,c6610df20b5c3ecd255a1a9b131360d2,2022-06-28 21:11:39,2022-06-28 21:11:39,2022-06-30 00:20:04

```

***

<br>

## PART 2: Modelling Challenge

* How are our users moving through the product funnel?


```

		{{ 
		    config(
		        materialized = 'table'
		    )  
		}}

		WITH product_funnel AS (
		-- Product Funnel 
		SELECT 
		  count(distinct(session_guid)) AS total_sessions 
		  , count( distinct case when page_view > 0 then session_guid end) AS page_views
		  , count( distinct case when add_to_cart > 0 then session_guid end) AS add_to_carts 
		  , count( distinct case when checkout > 0 then session_guid end) AS checkouts
		FROM 
		  dbt_heidi_s.fact_page_views
		)
		SELECT 
		  add_to_carts::numeric / page_views::numeric  -- land and add funnel flow 
		  , checkouts::numeric / add_to_carts::numeric -- add to purchase funnel flow 
		FROM 
		  product_funnel
		; 


total_sessions 	land_and_add_funnel 		add_and_purchase_funnel 
578				0.80795847750865051903  	0.77301927194860813704
```



<br>

**How are our users moving through the product funnel?**

```
			SELECT
			    SUM(page_view_flag) AS count_page_views
			    , SUM(add_to_cart_flag) AS count_add_to_carts
			    , SUM(checkout_flag) AS count_checkouts
			FROM dbt_junji_s.fct_greenery__sessions_users
```
**Answer**: By session, 578 of users have viewed a page, 467 of users got to the add-to-cart page, and 361 got to the check out page.

<br>

**Which steps in the funnel have largest drop off points?**
```
		SELECT
		    ROUND(SUM(add_to_cart)*100 / SUM(page_view), 2) AS step_1_funnel_conversion
		    , ROUND(SUM(checkout)*100 / SUM(add_to_cart), 2) AS step_2_funnel_conversion 
		FROM dbt_heidi_s.fact_page_views

		52.70 		36.61
```
**Answer**: 
The conversion rate for step 1 is 52% where folks view and then add to cart. 
The conversion rate for step 2 is 36% where folks purchase their cart.  
The biggest drop off points are to get more add to cart (48%) and to convert the remainder of 16% of folks who drop off before purchases. 

<br>


Exposure 
```
version: 2

exposures:  
  - name: Product_Funnel_Dashboard
    description: >
      Models that are critical to our product funnel dashboard
    type: dashboard
    maturity: high
    owner:
      name: Heidi Schmidt
      email: bb00p04@gmail.com
    depends_on:
      - ref('product_funnel')
```

***

<br>

## PART 3: Reflection

### 3A. dbt next steps for you 
Create a presentation that quantifies why Airflow on it's own isn't the place this type of ETL should take place. 
Use S.T.A.R. to explain the situation, the task really at hand, the actions to take, and the response (which dbt can fufill)
Prove that the model is user-ful and needed in order to capture the right data to answer the right questions
The documentation and areas of responsibility (exposures) is most awesome. 
We lose quickly who did what and who is still with or not with the company when it gets larger. 
Knowing code is or is not being maintained is key to pruning off or remaking old code to keep up with needs and changes. 


### 3B. Setting up for production / scheduled dbt run of your project 

DBT can run in Docker so it's a matter more of making sure who needs to do what and answer these questions.
And with Git and the ability to pull in a project to gitlab, then it is important to see if the methodology can be one of throw away 
	Rough idea:
	1. Allow the git checkout of the branch they want to work with in a dev environment
	2. Allow them to create what they think is needed and commit that code for review 
	3. Have the objects created in the backing store to be vetted and view/vet for design (does it answer the questions, what can we do with those answers)

* Who will be the admins of DBT? 
* What will a successful run of DBT look like and who wants to use it? 
* Who will consume the data and from where? (if they don't care how it runs and only want the data -- then the first iteration can be anywhere)


