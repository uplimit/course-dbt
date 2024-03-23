{{
    config(
        materialized = 'table'
        , unique_key = 'user_id'
    )
}}

select 
    -- ToDo: user_id column right now has dupes which potentially needs to be fixed!
    u.user_id
    , u.first_name
    , u.last_name
    , u.email 
    , u.phone_number
    , u.created_at
    , u.updated_at
    , u.address_id

from {{ source('greenery_sources','users') }} u