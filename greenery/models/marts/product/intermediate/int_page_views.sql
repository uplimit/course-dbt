{{
    config(
        materialized = 'table'
        , unique_key = 'pageview_id'
    )
}}
/*
Grain/primary key : One row per event_id
Stakeholders : Product Team (Product Manager X)
Purpose : Understand page view data by adding/enriching it with more data points
ToDos: Replace select * in this model with a jinja list!
*/

select 
    -- event data 
    e.event_id as pageview_id
    , e.session_id 
    , e.user_id 
    , e.event_type 
    , e.page_url 
    , e.created_at as event_created_at
    , e.product_id 
    -- booleans 
    , case when dayname(e.created_at) in ('Sat','Sun') then true else false end as event_is_from_weekend

from {{ ref('postgres__events') }} e

where e.event_type = 'page_view'
