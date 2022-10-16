{{
  config(
    materialized='table'
  )
}}

WITH users AS (
    SELECT *
    
    FROM {{ ref('stg_users') }}
),

addresses AS (
    SELECT *
    
    FROM {{ ref('stg_addresses') }}
)

SELECT
DISTINCT
u.user_id,
u.first_name,
u.last_name,
u.email,
u.phone_number,
u.created_at,
u.updated_at,
a.address,
a.zipcode,
a.state,
a.country 

FROM users u 
LEFT JOIN addresses a 
ON u.address_id = a.address_id