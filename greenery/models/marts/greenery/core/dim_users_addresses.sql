{{ 
    config(
        materialized = 'table'
        ) 
}}

WITH users AS (
    SELECT *
    FROM 
        {{ 
            ref('stg_greenery__users') 
        }}
)
, addresses AS (
    SELECT *
    FROM 
        {{ 
            ref('stg_greenery__addresses') 
        }}
)
SELECT 
    u.first_name
    , u.last_name
    , u.user_guid
    , u.email
    , u.phone_number
    , a.street_address
    , a.zipcode
    , a.state
    , a.country
    , u.created_at_utc
    , u.updated_at_utc 
    , age(date_trunc('day', CURRENT_DATE),date_trunc('day',u.created_at_utc)) as days_of_membership 
FROM users u
LEFT JOIN addresses a 
     ON a.address_guid = u.address_guid

