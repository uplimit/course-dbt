{{
    config(
        materialzed = 'view'
    )
}}

WITH users_source AS (
    SELECT
        user_id
        , first_name
        , last_name
        , email
        , phone_number
        , created_at
        , updated_at
        , address_id
    FROM
        {{
            source('greenery', 'users')
        }}
)

, renamed_casted AS (
    SELECT
       user_id AS user_guid
        , first_name
        , last_name
        , email
        , phone_number
        , created_at AS created_at_utc
        , updated_at AS updated_at_utc  
        , address_id AS address_guid
    FROM 
        users_source  
)

SELECT 
       user_guid
        , first_name
        , last_name
        , email
        , phone_number
        , created_at_utc
        , updated_at_utc
        , address_guid
FROM 
    renamed_casted
