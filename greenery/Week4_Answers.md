## Week 4 

# Part 1

**Snapshots**

Please see `snapshots/snapshot_orders.sql`!

# Part 2

**Modeling challenge - Product Funnel Analysis**

I created an intermediate table `int_funnel_events` to aggregate each steps of the funnel, and a fact table `fct_product_funnel_analysis` to calculate drop off points. 

Defination of funnel steps:
* Visits: Sessions with any event of type page_view / add_to_cart / checkout
* Activates: Sessions with any event of type add_to_cart / checkout
* Purchases: Sessions with any event of type checkout

Query and results:

```sql
SELECT *
FROM dbt_zoe_l.fct_product_funnel_analysis
```

| step      | count | lag  | drop_off |
|-----------|-------|------|----------|
| Visits    | 578   | NULL | NULL     |
| Activates | 467   | 578  | 0.19     |
| Purchases | 361   | 467  | 0.23     |

**Adding Exposure**

Please see `models/exposures.yml`!

# Part 3

*3A*

Before this course I was a traditional data analyst with zero dbt knowledge, but now I feel more confident contributing to data modeling at my own company (I pushed up my first modeling PR at work and it got merged to production this week!) 

Not only dbt, now I'm also more comfortable using Git and command lines, so I think this course definitely helped building a strong knowledge foundation for me. 

So in general, yay thank you Greenery! :)

*3B*

Maybe not very expert but just some of my thoughts so far:

- Use dbt Cloud to schedule jobs
- Depending on business needs, but at least once a day
- Use artifacts to monitor model performance over time, for example `run_results.jason`
- Send job failure alarts to relevant slack channel