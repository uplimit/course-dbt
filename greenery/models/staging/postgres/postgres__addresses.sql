with source as (
    select * from {{ source('postgres','addresses') }}
),
renamed as 
(
    select 
    address_id
    ,address
    ,lpad(zipcode,5,0) as zipcode
    ,state
    ,country
    from source 
)
select * from renamed