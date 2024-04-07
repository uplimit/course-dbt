{{
    config(
        materialized = 'table'
        , unique_key = 'event_id'
    )
}}
/*
Grain/primary key : One row per event_id
Stakeholders : Product Team (Product Manager X)
Purpose : Build an intermediate model to house all event data
ToDos: Replace select * in this model with a jinja list!
*/

select 
    -- event data 
    e.event_id
    , e.session_id 
    , e.user_id 
    , e.page_url 
    , e.event_type 
    , e.created_at as event_created_at
    , e.order_id
    , e.product_id 
    -- booleans 
    , case when dayname(e.created_at) in ('Sat','Sun') then true else false end as event_is_from_weekend

from {{ ref('postgres__events') }} e
