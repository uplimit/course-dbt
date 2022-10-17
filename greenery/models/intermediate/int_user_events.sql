
{{
  config(
    materialized='table'
  )
}}

select
  e.user_id,
  count(distinct e.session_id) num_sessions,
  min(e.created_at) first_session_date,
  max(e.created_at) last_session_date,
  datediff(hour, first_session_date, last_session_date) total_session_duration,
  count( case when e.event_type = 'checkout' then event_id else null end) checkout,
  count( case when e.event_type = 'package_shipped' then event_id else null end) package_shipped,
  count( case when e.event_type = 'page_view' then event_id else null end) page_view,
  count( case when e.event_type = 'add_to_cart' then event_id else null end) add_to_cart,
  count(e.order_id) total_orders,
  count(e.product_id) total_products
from {{ ref('stg_events')}} e
group by 1