{{
    config(
        materialized='view'
    )
}}

with events_source as (
    select * from {{source('src_greenery','events')}}

)

, renamed_recast as (
    select
    event_id,
    session_id,
    user_id,
    event_type,
    page_url,
    created_at,
    order_id,
    product_id


    from events_source
)


select * from renamed_recast 