{{
    config(
        materialized = 'table'
        , unique_key = 'user_id'
    )
}}
/*
Grain/primary key : One row per user_id
Stakeholders : Product Team (Product Manager X)
Purpose : Understand user data by adding/enriching it with more data points
*/

select 
    -- user data 
    u.user_id 
    , u.first_name as user_first_name
    , u.last_name as user_last_name 
    , u.email as user_email 
    , u.phone_number as user_phone_number
    , u.created_at as user_created_at 
    , u.updated_at as user_updated_at 
    -- address 
    , a.address as user_address 
    , a.zipcode as user_zipcode 
    , a.state as user_state 
    , a.country as user_country
    -- booleans 
    -- Assumption : Assuming Greenery's HQ is in the US
    , case when a.country != 'United States' then true else false end as user_has_international_address

from {{ ref('postgres__users') }} u

left join {{ ref('postgres__addresses') }} a
    on u.address_id = a.address_id 

