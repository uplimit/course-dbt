{{
  config(
    materialized='table'
  )
}}

WITH source_users AS (
    SELECT * FROM {{ source( 'postgres', 'users' ) }}
)

, renamed_recast AS (
    SELECT user_id AS user_guid
           , lower(REPLACE(first_name,' ','_')) AS first_name
           , lower(REPLACE(last_name,' ','_')) AS last_name
           , lower(email) AS email
           , phone_number
           , created_at::timestamp AS created_at_utc
           , updated_at::timestamp AS updated_at_utc
           , address_id AS address_guid
    FROM source_users
)

SELECT * FROM renamed_recast