SELECT
    address_id,
    address,
    zipcode AS zip_code,
    state,
    country
FROM {{ source('tutorial', 'addresses') }}
