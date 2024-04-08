{{
    config(
        materialized = 'table'
        , unique_key = 'event_id'
    )
}}

select 
    e.event_id
    , e.session_id 
    , e.user_id 
    , e.page_url
    , e.created_at
    , e.event_type 
    , e.order_id 
    , e. product_id 

from {{ source('postgres','events') }} e