-- stg_public__promos.sql

with

source as (

    select * from {{ source('public', 'promos') }}

),

source_standardized as (

    select
          promo_id
        , discount  as promo_discount
        , status    as promo_status

    from source

)

select * from source_standardized