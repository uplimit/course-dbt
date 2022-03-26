{{
  config(
    materialized='view'
  )
}}

with product as (
    select * from {{ref('int_sessions_grouped_by_product')}}
)

-- calculate funnel conversion rates 

select 
  product_id 
    -- # of unique sessions with add to cart event / # of unique sessions with a page view 
  , round((unique_add_to_cart_sessions::numeric/ unique_page_view_sessions::numeric) * 100, 2) as view_cart_conversion_rate 

 --  # of unique sessions with purchase event / # of unique sessions with add to cart  
  ,  round((unique_purchase_sessions::numeric/ unique_add_to_cart_sessions::numeric) * 100, 2) as cart_purchase_conversion_rate 

  -- # of unique sessions with purchase event / # of unique sessions with a page view 
  , round((unique_purchase_sessions::numeric/ unique_page_view_sessions::numeric) * 100, 2) as view_purchase_conversion_rate 
from product
