{{ 
    config(
        MATERIALIZED = 'table'
    )
}}

WITH users_source AS 
(
    SELECT 
        created_at
        , updated_at
        , user_id
        , first_name
        , last_name
        , email
        , phone_number
        , address_id
    FROM
        {{ source('postgres', 'users') }}
)

SELECT 
    us.created_at
    , us.updated_at
    , us.user_id
    , us.first_name
    , us.last_name
    , us.email
    , us.phone_number
    , us.address_id
FROM users_source us