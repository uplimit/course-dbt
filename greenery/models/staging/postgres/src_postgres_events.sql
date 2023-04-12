{{ 
    config(
        MATERIALIZED = 'table'
    )
}}

WITH events_source AS 
(
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
        {{ source('postgres', 'events') }}
)

, page_url_definition AS 
(
    SELECT
        es.event_id
        , es.session_id
        , es.user_id
        , es.page_url
        , REGEXP_SUBSTR(es.page_url,'https:\/\/greenary.com\/(.*)\/',1, 1, 'e', 1) AS page_url_type
        , es.created_at
        , es.event_type
        , es.order_id
        , es.product_id
    FROM
        events_source es
)

SELECT 
    pud.event_id
    , pud.session_id
    , pud.user_id
    , pud.page_url
    , pud.page_url_type
    , pud.created_at
    , pud.event_type
    , pud.order_id
    , pud.product_id
FROM page_url_definition pud
