{{config(
    materialized='table'
) }}

with sources as (
    select * from {{ source('greenery_src', 'events') }} as events
)

, rename_recast as (
    SELECT
        event_id,
        session_id,
        user_id,
        page_url,
        event_type,
        order_id,
        product_id,
        created_at as created_at_utc
    FROM sources
)

select * from rename_recast