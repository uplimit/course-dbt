{{
  config(
    materialized='table'
  )
}}


with session_timing as (
  select * from {{ ref('int_session_timing') }}
)

select 
    e.session_id,
    e.user_id,
    coalesce(e.product_id, oi.product_id) as product_id,
    session_started_at,
    session_ended_at,
    sum(case when event_type = 'checkout' then 1 else 0 end) as count_checkout,
    sum(case when event_type = 'package_shipped' then 1 else 0 end) as count_package_shipped,
    sum(case when event_type = 'add_to_cart' then 1 else 0 end) as count_add_to_cart,
    sum(case when event_type = 'page_view' then 1 else 0 end) as count_page_view,
    datediff('minute', session_started_at, session_ended_at) as session_length
    from {{ ref('stg_postgres__events') }} e
left join {{ ref('stg_postgres__order_items') }} oi using (order_id)
left join session_timing using (session_id)
group by 1,2,3,4,5 
