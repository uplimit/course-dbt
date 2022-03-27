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
