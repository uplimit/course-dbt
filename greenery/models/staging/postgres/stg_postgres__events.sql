
with src_events as (
    select * from {{ source('postgres', 'events')}}
)
, renamed_recast as (
    select 
        event_id    as event_guid
        , session_id                 as session_guid
        , user_id                    as user_guid
        , page_url
        , created_at::timestampntz   as created_at_utc
        , event_type
        , order_id                   as order_guid
        , product_id                 as product_guid

    from src_events
)
select * from renamed_recast