{{
    config(materialized = 'table')
}}

with source as (
    select promo_id
    , discount
    , status from {{ source('postgres', 'promos') }}
)

, renamed_recast as (
    select
        promo_id as promo_guid
        , discount
        , status
    from source
)

select * from renamed_recast