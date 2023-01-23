with page_views as (

    select
        event_id,
        session_id,
        user_id,
        product_id,
        page_url,
        created_at_utc,
        rank() over (partition by session_id order by created_at_utc) as page_view_sequence
    from
        {{ ref('stg_postgres__events') }}
    where
        event_type = 'page_view'
        
)

select * from page_views
