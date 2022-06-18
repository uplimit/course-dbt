-- stg_public__events.sql

with

source as (

    select * from {{ source('public', 'events') }}

),

source_standardized as (

    select
          event_id    as event_guid
        , session_id  as session_guid
        , user_id     as user_guid
        , page_url
        , created_at  as created_at_utc
        , event_type
        , order_id    as order_guid
        , product_id  as product_guid

    from source

)

select * from source_standardized