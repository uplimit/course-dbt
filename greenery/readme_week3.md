## Part 1
## What is our overall conversion rate?
select count(distinct case when count_checkout > 0 then session_id end) / count (distinct session_id) as conversion_rate from dev_db.dbt_juliepanteleevagmailcom.fact_page_views

Answer: 0.624567

## What is our conversion rate by product?
select 
    pv.product_id, 
    name as product_name, 
    count(distinct case when count_checkout > 0 then session_id end) / count(distinct pv.session_id) as conversion_rate
from dev_db.dbt_juliepanteleevagmailcom.fact_page_views as pv
left join dev_db.dbt_juliepanteleevagmailcom.stg_postgres__products as p on p.product_id = pv.product_id
group by 1,2

Answer: 
String of pearls	0.609375
Arrow Head	0.555556
Pilea Peperomioides	0.474576
Rubber Plant	0.518519
Cactus	0.545455
Money Tree	0.464286
Aloe Vera	0.492308
Fiddle Leaf Fig	0.5
Ponytail Palm	0.4
Pink Anthurium	0.418919
Calathea Makoyana	0.509434
Alocasia Polly	0.411765
Monstera	0.510204
Birds Nest Fern	0.423077
ZZ Plant	0.539683
Boston Fern	0.412698
Orchid	0.453333
Jade Plant	0.478261
Philodendron	0.483871
Ficus	0.426471
Snake Plant	0.39726
Dragon Tree	0.467742
Devil's Ivy	0.488889
Bamboo	0.537313
Angel Wings Begonia	0.393443
Bird of Paradise	0.45
Peace Lily	0.409091
Pothos	0.344262
Spider Plant	0.474576
Majesty Palm	0.492537


## Part 6
## Which products had their inventory change from week 2 to week 3?
## Pothos, Philodendron, Bamboo, ZZ Plant, Monstera, String of pearls