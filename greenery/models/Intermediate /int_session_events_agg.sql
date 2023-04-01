{{ 
    config(
        MATERIALIZED = 'table'
    )
}}

with events as (
    select * from {{ ref('stg_postgres_events') }}
),
final as (
    select 
    event_id,
    session_id,
    sum(case when event_type = 'add_to_cart' then 1 else 0 end) as add_to_carts,
    sum(case when event_type = 'checkout' then 1 else 0 end) as checkouts,
    sum(case when event_type = 'package_shipped' then 1 else 0 end) as package_shippeds,
    sum(case when event_type = 'page_view' then 1 else 0 end) as page_views,
    min(event_created_at_utc) as first_session_event_at_utc,
    max(event_created_at_utc) as last_session_event_at_utc
    from {{ref('stg_postgres_events')}}
    group by 1,2

)
select * from final 