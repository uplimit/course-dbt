{{ config(materialized='table') }}

with src_users as (
    select * from {{ source('postgres','users' )}}
)

, renamed_recast as (
    SELECT
        USER_ID as user_guid
        , FIRST_NAME as first_name
        , LAST_NAME as last_name
        , EMAIL as email
        , PHONE_NUMBER as phone_number
        , CREATED_AT::timestampntz as created_at_utc
        , UPDATED_AT::timestampntz as updated_at_utc
        , ADDRESS_ID as address_guid
    from src_users
)

select * from renamed_recast