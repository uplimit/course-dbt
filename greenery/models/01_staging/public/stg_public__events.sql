-- stg_events.sql

with

source as (

    select * from {{ source('public', 'events') }}

)

select * from source