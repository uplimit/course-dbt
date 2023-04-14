{{
    config(materialized = 'table')
}}

with source as (
    select event_id
    , session_id
    , user_id
    , page_url
    , created_at
    , event_type
    , order_id
    , product_id from {{ source('postgres', 'events') }}
)

, renamed_recast as (
    select
        event_id as event_guid
        , session_id as session_guid
        , user_id as user_guid
        , page_url
        , created_at
        , event_type
        , order_id as order_guid
        , product_id as product_guid
    from source
)

select * from renamed_recast