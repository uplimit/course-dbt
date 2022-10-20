{{
  config(
    post_hook={
        "sql": "DESCRIBE TABLE {{this}};"
        , "transaction": True
    }
  )
}}

SELECT
    address_id
    , address AS street_address
    , LPAD(zipcode::VARCHAR, 5, 0) AS zip_code
    , state AS state_name
    , country AS country_name
FROM {{ source('postgres', 'addresses') }}
