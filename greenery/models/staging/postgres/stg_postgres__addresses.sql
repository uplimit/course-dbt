with src_addresses as (
    select * from {{ source('postgres', 'addresses')}}
)
, renamed_recast as (
    select 
        address_id     as address_guid
        , address
        , zipcode
        , state
        , country
    from src_addresses
)
select * from renamed_recast