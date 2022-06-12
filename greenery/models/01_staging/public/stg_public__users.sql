-- stg_users.sql

with

source as (

    select * from {{ source('public', 'users') }}

)

select * from source