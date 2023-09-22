{{
  config(
    materialized='table'
  )
}}

SELECT
a.user_id, 
a.first_name, 
a.last_name, 
a.email, 
a.phone_number, 
DATE(a.created_at) as created_at,
DATE(a.updated_at) as updated_at,
a.address_id, 
b.address,
b.zipcode,
b.country,
b.state


FROM {{ ref('stg_users') }} a
LEFT JOIN {{ ref('stg_addresses') }} b
ON a.address_id = b.address_id