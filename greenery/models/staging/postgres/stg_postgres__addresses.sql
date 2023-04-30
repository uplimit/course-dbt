{{ 
    config(
        MATERIALIZED = 'table'
    )
}}

WITH addresses_source AS 
(
    SELECT
        address_id
        , address
        , state
        , zipcode
        , country
    FROM
        {{ source('postgres', 'addresses') }}
)

, zipcode_adjustment AS
(
    SELECT 
        os.address_id
        , os.address
        , os.state
        , LPAD(os.zipcode, 5, '0') AS zip_code
        , os.country
    FROM addresses_source os
)

SELECT 
    za.address_id
    , za.address
    , za.state
    , za.zip_code
    , za.country
FROM zipcode_adjustment za
