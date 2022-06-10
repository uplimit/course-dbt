{{
    config(
        materialzed = 'view'
    )
}}

WITH addresses_source AS (
    SELECT
        address_id
        , address
        , zipcode
        , state
        , country
    FROM
        {{
            source('greenery', 'addresses')
        }}
)

, renamed_casted AS (
    SELECT
        address_id as address_guid
        , address as street_address 
        , lpad(zipcode::varchar, 5, '0') as zipcode -- will put a 0 in front of a stripped zip, making it fit 5 digits
        , state
        , country       
    FROM 
        addresses_source  
)

SELECT 
        address_guid
        , street_address
        , zipcode
        , state
        , country 
FROM 
    renamed_casted
