SELECT
    address_id,
    address,
    zipcode,
    state,
    country

from {{ source('greenery', 'addresses')}}