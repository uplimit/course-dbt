{{
  config(
    materialized='table'
  )
}}

select
    uo.user_id, 
    uo.total_orders,
    uo.total_promos_used,
    uo.recent_order_date,
    uo.total_spent,
    ue.num_sessions,
    ue.first_session_date,
    ue.last_session_date,
    ue.total_session_duration,
    ue.checkout as session_checkout,
    ue.package_shipped as session_package_shipped,
    ue.page_view as session_page_view,
    ue.add_to_cart as session_add_to_cart
from {{ ref('int_user_orders')}} uo
left join {{ ref('int_user_events')}} ue
on uo.user_id = ue.user_id