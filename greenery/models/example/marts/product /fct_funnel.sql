{{
    config(
        materialized = 'table'
    )
}}


with t1 as (
SELECT 
sum(CASE WHEN checkout_sum>0 THEN 1 END) as funnel3
,sum(CASE WHEN checkout_sum>0 or add_to_cart_sum>0 THEN 1 END) as funnel2
,sum(CASE WHEN checkout_sum>0 or add_to_cart_sum>0 or page_view_sum>0  THEN 1 END) as funnel1
 from dbt_sofia.init_funnel )

 select *,
  funnel1 - funnel2 as dif1_2,
  funnel2 - funnel3 as dif2_3 
from t1

