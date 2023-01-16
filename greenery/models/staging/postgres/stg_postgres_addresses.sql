with src_address as (
    select * from {{ source('postgres', 'addresses') }}
),
renamed_recast as (
    select 
    address_id as address_id,
    address as address_line_1,
    zipcode as address_zipcode,
    state as address_state,
    country as address_country
    from src_address
)

select * from renamed_recast