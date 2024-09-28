{{
  config(
    materialized='view'
  )
}}

WITH events AS (
    SELECT * FROM {{ ref('stg_events') }}
) ,

final as (
  select 
    event_type
    , count(*) over(partition by event_type) as total_purchase_events
    , count(*) over() as total_events
  from events
)

select
  round(avg(total_purchase_events)/avg(total_events),4) as conversion_rate
from final
where event_type = 'package_shipped'
