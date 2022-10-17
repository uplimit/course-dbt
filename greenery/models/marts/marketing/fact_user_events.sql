
{{
  config(
    materialized='table'
  )
}}

select
  user_id,
  num_sessions,
  first_session_date,
  last_session_date,
  total_session_duration,
  checkout,
  package_shipped,
  page_view,
  add_to_cart,
  total_orders,
  total_products
from {{ ref('int_user_events')}} ue