{{
    config(
        materialized = 'table'
        , unique_key = 'pageview_id'
    )
}}

/*
Grain/primary key : One row per event_id
Stakeholders : Product Team (Product Manager X)
Purpose : Understand page view data by collating all related dimensions/facts 
ToDo: replace all select * in the model with a jinja list 
*/

select 
    pageviews.* 
    -- users 
    , users.* exclude user_id 
    -- orders 
    , products.* exclude product_id 

from {{ ref('int_page_views') }} pageviews

left join {{ ref('int_users') }} users 
    on pageviews.user_id = users.user_id 

left join {{ ref('int_products') }} products
    on pageviews.product_id = products.product_id 
