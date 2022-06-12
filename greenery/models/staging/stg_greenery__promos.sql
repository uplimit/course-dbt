with

source as (

    select * from {{ source('greenery', 'promos') }}

),

renamed as (
    select 
        promo_id,
        discount,
        status
    from source
)

select * from renamed
