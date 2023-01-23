with source as (
   
    select 
        * 
    from 
        {{ source('postgres', 'promos') }}

),

renamed as (

    select
        promo_id as promo_type,
        discount::decimal(20,2) as discount_usd,
        status as promo_status
    from 
        source
)

select * from renamed
  