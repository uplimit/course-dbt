{{
  config(
    materialized='view'
  )
}}

WITH events AS (
    SELECT * FROM {{ ref('stg_events') }}
) ,

view_sessions as (
  select 
    product_id
    , count(*) as total_view_sessions
  from events
  where event_type = 'page_view'
  group by 1
) ,

purchase_sessions as (
  select 
    product_id
    , count(*) as total_purchase_sessions
  from events
  where event_type = 'add_to_cart'
  group by 1
)

select
  t1.product_id
  , sum(total_view_sessions) as total_view_sessions
  , sum(total_purchase_sessions) as total_purchase_sessions
  , round(sum(total_purchase_sessions)/sum(total_view_sessions),4) as product_conversion_rate
from view_sessions t1 
left join purchase_sessions t2
  on t1.product_id = t2.product_id
group by 1