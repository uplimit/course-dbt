{{
    config(
        materialized = 'table'
        , unique_key = 'session_id'
    )
}}

/*
Grain/primary key : One row per session_id
Stakeholders : Product Team (Product Manager X)
Purpose : Understand session data
ToDo: replace all select * in the model with a jinja list 
*/

-- roll up event data at the session level 
with sessions as (
select  
    e.session_id 
    , e.user_id 
    -- min/max
    , min(e.event_created_at) as session_start_at
    , max(e.event_created_at) as session_end_at
    , max(case when e.order_id is not null then true else false end) as session_has_order
    , max(e.event_is_from_weekend) as session_has_weekend_event
    , listagg(distinct e.event_type,',') within group (order by e.event_type) as session_event_types
    -- counts 
    , count(distinct case when e.event_type = 'checkout' then e.event_id end) as count_of_checkout_events_in_session
    , count(distinct case when e.event_type = 'package_shipped' then e.event_id end) as count_of_package_shipped_events_in_session
    , count(distinct case when e.event_type = 'add_to_cart' then e.event_id end) as count_of_add_to_cart_events_in_session
    , count(distinct case when e.event_type = 'page_view' then e.event_id end) as count_of_page_view_events_in_session
    , count(distinct e.event_id) as count_of_events_in_session
    -- calcs 
    , datediff(minute,session_start_at,session_end_at) as session_duration_in_minutes

from {{ ref('int_events') }} e

group by 1,2
)
, product_sessions as (
select 
    e.session_id 
    , listagg(distinct p.product_name,',') within group (order by p.product_name) as session_product_types

from {{ ref('int_events') }} e

join {{ ref('int_products') }} p
    on e.product_id = p.product_id 

group by 1
)

select 
    -- sessions 
    s.* 
    -- users 
    , users.* exclude user_id 
    -- product sessions 
    , ps.session_product_types

from sessions s

left join {{ ref('int_users') }} users 
    on s.user_id = users.user_id 

left join product_sessions ps
    on s.session_id = ps.session_id