 {{
  config(
    materialized='table'
  )
}}
 
  select
    user_id
    , session_id
    , sum(case when event_type = 'add_to_cart' then 1 else 0 end) as add_to_cart_ct
    , sum(case when event_type = 'checkout' then 1 else 0 end) as checkout_ct
    , sum(case when event_type = 'package_shipped' then 1 else 0 end) as package_shipped_ct
    , sum(case when event_type = 'page_view' then 1 else 0 end) as page_view_ct
    , min(created_at) as first_session_event_at
    , max(created_at) as last_session_event_at
  from {{ ref('staging_postgres_events') }}
  group by 1,2