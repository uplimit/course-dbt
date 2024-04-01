with
events as ( select * from {{ref('stg_postgres__events')}}),
order_items as ( select * from {{ref('stg_postgres__order_items')}}),
session_agg as ( select * from {{ref('int_session_dates')}})

select 
    e.session_id,
    e.user_id,
    coalesce(e.product_id, o.product_id) as product_id,
    session_start_date,
    session_end_date,
    sum(case when e.event_type = 'page_view' then 1 else 0 end) as page_views,
    sum(case when e.event_type = 'add_ to_cart' then 1 else 0 end) as add_to_cart,
    sum(case when e.event_type = 'checkout' then 1 else 0 end) as checkouts,
    sum(case when e.event_type = 'package_shipped' then 1 else 0 end) as package_shipped
from events e
left join order_items o on e.order_id = o.order_id
left join session_agg s on s.session_id = e.session_id
group by 1,2,3,4,5