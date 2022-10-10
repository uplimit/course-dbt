
{{ config(materialized='view') }}

with users as (
    select 
    user_id as user_guid,
    first_name,
    last_name,
    concat(first_name,' ',last_name) as full_name,
    email,
    phone_number,
    convert_timezone('America/New_York',created_at) as created_at_tstamp_est,
    convert_timezone('America/New_York',updated_at) as updated_at_tstamp_est,
    address_id as address_guid
from {{source('postgres','users')}}

)

SELECT
*
from users