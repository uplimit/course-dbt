### Week 3 Project

### What is our overall conversion rate?

Our overall conversion rate is 0.624.

```
select 
count(distinct order_id) orders,
count( distinct session_id) unique_sessions,
orders/unique_sessions conversion_rate
from DEV_DB.DBT_PLE.STG_EVENTS events
```

### What is our conversion rate by product?
34% - 60% of conversion rate by product 

Run query below for more details

```
with ts as (
select 
    split_part(page_url, '/',5) product_id,
    products.name product_name,
    count( distinct events.session_id) total_sessions
from DEV_DB.DBT_PLE.STG_EVENTS events
join DEV_DB.DBT_PLE.STG_PRODUCTS products
on events.product_id = products.product_id
group by 1,2),

cs as (
select 
    orders.product_id,
    products.name product_name,
    count(  orders.order_id) total_orders
from DEV_DB.DBT_PLE.STG_ORDER_ITEMS orders
left join DEV_DB.DBT_PLE.STG_PRODUCTS products
on orders.product_id = products.product_id
group by 1,2)

select 
ts.product_id,
ts.product_name,
cs.total_orders,
ts.total_sessions,
cs.total_orders/ts.total_sessions conversion_rate
from ts
left join cs
on ts.product_id = cs.product_id
order by conversion_rate desc 
```

### Create a macro to simplify part of a model(s)

Created get_event_types macro and grant_select macros

### Add a post hook to your project to apply grants to the role “reporting”. 
 Done in dbt_project.yml

 ### Show (using dbt docs and the model DAGs) how you have simplified or improved a DAG using macros and/or dbt packages. DAG from week 2 to week 3

I added a product conversion rate model 

Week 3 -- https://8080-phle823-coursedbt-isqoczgarhp.ws-us72.gitpod.io/#!/overview?g_v=1

Week 2 -- https://corise.com/static/course/analytics-engineering-with-dbt/assets/cl9cv7lv800k711awbiuv0hnr/dbt-dag.png

### Which orders changed from week 2 to week 3? 

3 orders got shipped

Order IDs below got updated:
5741e351-3124-4de7-9dff-01a448e7dfd4
8385cfcd-2b3f-443a-a676-9756f7eb5404
e24985f3-2fb3-456e-a1aa-aaf88f490d70