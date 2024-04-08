with
    events as (select * from {{ ref("stg_postgres__events") }}),
    order_items as (select * from {{ ref("stg_postgres__order_items") }}),
    session_timing_agg as (select * from {{ ref("int_session_timings") }})
select
    events.session_id,
    events.user_id,
    coalesce(events.product_id, order_items.product_id) as product_id,
    session_started_at,
    session_ended_at,
    sum(case when events.event_type = 'page_view' then 1 else 0 end) as page_views,
    sum(case when events.event_type = 'add_to_cart' then 1 else 0 end) as add_to_carts,
    sum(case when events.event_type = 'checkout' then 1 else 0 end) as checkouts,
    sum(
        case when events.event_type = 'package_shipped' then 1 else 0 end
    ) as packages_shipped,
    datediff('minute', session_started_at, session_ended_at) as session_length_minutes
from events
left join order_items on order_items.order_id = events.order_id
left join session_timing_agg on session_timing_agg.session_id = events.session_id
group by 1, 2, 3, 4, 5
