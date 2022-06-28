{{
    config(
        materialzed = 'view'
    )
}}

WITH events_source AS (
    SELECT
         event_id
        , session_id
        , user_id
        , page_url
        , created_at
        , event_type
        , order_id
        , product_id  
    FROM
        {{
            source('greenery', 'events')
        }}
)

, renamed_casted AS (
    SELECT
        event_id AS event_guid
        , session_id AS session_guid
        , user_id AS user_guid
        , page_url
        , created_at AS created_at_utc
        , event_type
        , order_id AS order_guid
        , product_id AS product_guid
    FROM 
        events_source  
)

SELECT 
        event_guid
        , session_guid
        , user_guid
        , page_url
        , created_at_utc
        , event_type
        , order_guid
        , product_guid  
FROM 
    renamed_casted