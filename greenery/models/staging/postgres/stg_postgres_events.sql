with src_events as (
    select * from {{ source('postgres', 'events') }}
),
renamed_recast as (
    select 
    event_id, 
    session_id, 
    user_id, 
    page_url as event_page_url, 
    created_at::timestamp_ntz as event_created_at_utc, 
    event_type, 
    order_id, 
    product_id
    from src_events

)

select * from renamed_recast