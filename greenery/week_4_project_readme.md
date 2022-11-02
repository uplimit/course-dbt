### Week 4 Project

### Which orders changed from week 3 to week 4? 

The following order ids was shipped 
- d1020671-7cdf-493c-b008-c48535415611
- aafb9fbd-56e1-4dcc-b6b2-a3fd91381bb6
- 38c516e8-b23a-493a-8a5c-bf7b2b9ea995


### How are our users moving through the product funnel?

Out of the total sessions, 
- 58.14% completed a page view
- 30.64% added items to cart
- 11.21% checked out the items

Model here: fact_product_funnel
```
with sessions as (
select 
    sum(page_view + add_to_cart + checkout) as total_sessions,
    sum(page_view) page_view,
    sum(add_to_cart) add_to_cart,
    sum(checkout) checkout
from DEV_DB.DBT_PLE.INT_USER_EVENTS)

select 
    page_view/total_sessions*100 as page_view_rate,
    add_to_cart/total_sessions*100 as add_to_cart_rate,
    checkout/total_sessions*100 as checkout_rate
from sessions
```

### Which steps in the funnel have largest drop off points?

The page view to the add to cart steps of the funnel had the largest drop off point at 27.5%

### Reflecting on your learning in this class...

### if your organization is using dbt, what are 1-2 things you might do differently / recommend to your organization based on learning from this course?

I would recommend to 
- use some of the macros we learned in class that helps with efficiency when creating documentation like generate yaml using the codegen package
- upgrade to a new version of dbt since there are helpful packages that require new version of dbt
- share that benefits of creating intermediate tables and fact tables since it looks like we don't really have that based on some of the models I looked at
- add more tests for models to ensure data quality

Updated DAG: https://8080-phle823-coursedbt-isqoczgarhp.ws-us73.gitpod.io/#!/overview?g_v=1