{{
  config(
    materialized='table'
  )
}}

select 
    distinct session_id,
    user_id, 
    sum(case when event_type = 'checkout' then 1 else 0 end) as count_checkout,
    sum(case when event_type = 'package_shipped' then 1 else 0 end) as count_package_shipped,
    sum(case when event_type = 'add_to_cart' then 1 else 0 end) as count_add_to_cart,
    sum(case when event_type = 'page_view' then 1 else 0 end) as count_page_view
    from {{ ref('stg_postgres__events') }}
left join {{ ref('stg_postgres__order_items') }} using (order_id)
group by 1,2
