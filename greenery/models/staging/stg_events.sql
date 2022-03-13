with 

source as (
    select  
        -- UUID of each unique event on the platform
        event_id,
        -- UUID of each browsing session on the platform which can contain many events
        session_id,
        -- UUID of the user that this event is associated with
        user_id,
        -- URL that the event happened on
        page_url,
        -- Timestamp of the event
        created_at,
        -- Type of event
        event_type,
        -- If the event is specific to an order (mostly used for checkout)
        order_id,
        -- If the event is specific to a product
        product_id
    from {{ source('greenery', 'events') }}
)

select * from source