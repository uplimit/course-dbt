-- stg_promos.sql

with

source as (

    select * from {{ source('public', 'promos') }}

)

select * from source