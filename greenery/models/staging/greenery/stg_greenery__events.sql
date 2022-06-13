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
        event_id AS event_id_guid
        , session_id AS session_id_guid
        , user_id AS user_id_guid
        , page_url
        , created_at AS created_at_utc
        , event_type
        , order_id AS order_id_guid
        , product_id AS product_id_guid
    FROM 
        events_source  
)

SELECT 
        event_id_guid
        , session_id_guid
        , user_id_guid
        , page_url
        , created_at_utc
        , event_type
        , order_id_guid
        , product_id_guid  
FROM 
    renamed_casted