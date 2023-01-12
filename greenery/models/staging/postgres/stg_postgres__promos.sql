with src_promos as (
    select * from {{ source('postgres', 'promos')}}
)
, renamed_recast as (
    select 
        promo_id as promo_description
        , discount
        , status
    from src_promos
)
select * from renamed_recast