{{ 
  config(
    materialized='view'
  ) 
}}

with events as (

    select * from {{ source('_postgres__sources', 'events') }}

)

select
    event_id, 
    session_id, 
    user_id, 
    page_url, 
    created_at, 
    event_type, 
    order_id, 
    product_id

from events