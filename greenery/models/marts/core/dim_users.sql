{{ config(
    tags=['PII']
)
}}

SELECT 
     users.user_id
    ,CONCAT(users.first_name, ' ', users.last_name) AS user_name
    ,CONCAT(addresses.address, ', ', addresses.state, ' ', addresses.zip_code, ', ', addresses.country) AS address
    ,users.email
    ,users.phone_number
    ,users.created_at_utc
    ,users.updated_at_utc
FROM {{ ref('stg_users') }} users
LEFT JOIN {{ ref('stg_addresses') }} addresses ON users.address_id = addresses.address_id
