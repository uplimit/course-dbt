# Welcome my dbt project!
## These are the answers for the project of week #3!
### (Part 1) Models - Answers

 What is our overall conversion rate? 62.46%

```
with purchace_events as (
select count(distinct session_id) as total_purchases
from dbt."dbt_Marios_A".fact_events
where event_type = 'checkout') ,

total_events as ( 
select count(distinct session_id) as events
from dbt."dbt_Marios_A".fact_events )

select round(a.total_purchases / b.events:: numeric  * 100 ,2 )
from purchace_events a , total_events b
```

What is our conversion rate by product?

```
WITH purchace_events AS
(
	SELECT  product_id
	       ,product_name
	       ,COUNT(distinct session_id) AS total_purchases
	FROM dbt."dbt_Marios_A".fact_sessions
	WHERE event_type = 'checkout'
	GROUP BY  1
	         ,2
) , total_events AS
(
	SELECT  product_id
	       ,product_name
	       ,COUNT(distinct session_id) AS events
	FROM dbt."dbt_Marios_A".fact_sessions
	GROUP BY  1
	         ,2
)
SELECT  a.product_id
       ,a.product_name
       ,round(a.total_purchases / b.events:: numeric * 100 ,2 ) AS conversion_rate_pp
FROM purchace_events a
LEFT JOIN total_events b
ON a.product_id = b.product_id AND a.product_name = b.product_name
ORDER BY 3 desc
LIMIT 10
```
Table of results (limiting them for visualization purposes)
| product_name          | conversion_rate_pp |
| -------------         | ------------- |
| String of pearls      | 60.94  |
| Arrow Head            | 55.56  |
| Cactus                | 54.55  |
| ZZ Plant              | 53.97  |
| Bamboo                | 53.73  |
| Rubber Plant          | 51.85  |
| Monstera              | 51.02  |
| Calathea Makoyana     | 50.94  |
| Fiddle Leaf Fig       | 50.00  |

### (Part 2) Macro - Answers

What assumptions are you making about each model? (i.e. why are you adding each test?)

- The main focus was given in all primary keys (ids) not to be null and unique and this was the main tests made in our project
- The secodary focus has give in some other columns to not be null and have a data in order to be used in our analysis
- Last check I did was to have a positive value to each total of each order.

Did you find any “bad” data as you added and ran tests on your models? How did you go about either cleaning the data in the dbt model or adjusting your assumptions/tests?

 - No, I was happy to see all my test to be completed successfully!

Your stakeholders at Greenery want to understand the state of the data each day. Explain how you would ensure these tests are passing regularly and how you would alert stakeholders about bad data getting through.

If you want to ensure these tests that are passing in a regular basis you should definately add the source freshness checks as part of the daily workflow that will schedule this whole workflow. In order to be more specific I would connect these tests even with slack to be notified in almost real time manner. ( I am 99% sure this functionality exists, I need to check :) )