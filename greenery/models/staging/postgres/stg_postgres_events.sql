{{ config(materialized='table') }}

with src_events as (
    select * from {{ source('postgres','events' )}}
)

, renamed_recast AS (
    SELECT 
        EVENT_ID as event_guid
      , SESSION_ID as session_guid
      , USER_ID as user_guid
      , PAGE_URL as page_url
      , CREATED_AT::timestampntz as created_at_utc
      , EVENT_TYPE as event_type
      , ORDER_ID as order_guid
      , PRODUCT_ID as product_guid
    FROM src_events
)

select * from renamed_recast