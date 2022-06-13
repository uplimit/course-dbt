-- stg_public__promos.sql

with

source as (

    select * from {{ source('public', 'promos') }}

),

standardized as (

    select
        promo_id,
        discount,
        status

    from source

)

select * from source