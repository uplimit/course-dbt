with source as (

    select 
        * 
    from 
        {{ source('postgres', 'events') }}
),

renamed as (

    select
        event_id,
        session_id,
        user_id,
        order_id,
        product_id,
        page_url,
        created_at::timestampntz as created_at_utc,
        event_type
    from 
        source

)
select * from renamed 