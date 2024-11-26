

{{ config(materialized='view') }}


with events as (
    select 
        event_id as event_guid,
        session_id as session_guid,
        user_id as user_guid,
        page_url,
        convert_timezone('America/New_York',created_at) as created_at_tstamp_est,
        event_type,
        order_id as order_guid,
        product_id as product_guid
    from   {{source('postgres','events')}}


)

SELECT
*
from events