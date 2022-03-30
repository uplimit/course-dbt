{{ config(
    tags=['PII']
)
}}

WITH user_address AS(
    SELECT *
    FROM {{ ref('int_user_address')}}
)

SELECT 
    user_id
    ,user_name
    ,address
    ,email
    ,phone_number
    ,created_at_utc
    ,updated_at_utc
FROM user_address