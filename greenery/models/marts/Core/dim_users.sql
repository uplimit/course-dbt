{{ config(materialized = 'view') }}

WITH users AS (
    SELECT * FROM {{ ref('stg_users') }}
)

, addresses AS (
    SELECT * FROM {{ ref('stg_addresses') }}
)

SELECT
  users.user_id
  , users.first_name
  , users.last_name
  , users.email
  , users.phone_number
  , users.created_at
  , users.updated_at
  , users.address_id
  , addresses.address
  , addresses.zipcode
  , addresses.state
  , addresses.country
FROM users
LEFT JOIN addresses
  ON users.address_id = addresses.address_id