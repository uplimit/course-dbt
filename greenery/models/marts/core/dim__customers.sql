 {{
  config(
    materialized='table'
  )
}}

WITH users AS (
    SELECT
          stgu.user_id
        , stgu.first_name
        , stgu.last_name
        , stgu.email
        , stgu.phone_number
        , stgu.address_id
        , stgad.address
        , stgad.state
        , stgad.zip_code
        , stgad.country
        , stgu.created_at
        , stgu.updated_at
    FROM {{ ref('stg_postgres__users') }} AS stgu
    JOIN {{ ref('stg_postgres__addresses') }} AS stgad ON stgu.address_id = stgad.address_id
)

SELECT 
    * 
FROM users