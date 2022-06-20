{{
    config(
        materialized='table'
    )
}}

select 
session_id
, created_at
,user_id
,sum(case when event_type='package_shipped' then 1 else 0 end) as package_shipped
,sum(case when event_type='page_view' then 1 else 0 end) as page_view
,sum(case when event_type='checkout' then 1 else 0 end) as checkout
,sum(case when event_type='add_to_cart' then 1 else 0 end) as add_to_cart
from {{ref('stg_greenery_events')}}
group by 1,2,3