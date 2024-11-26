{{ config(materialized='table') }}


with src_events as (
    select
    *
    FROM
    {{ref('src_events')}}
)


,dim_users as (
    SELECT
    *
    from {{ref('dim_users')}}
)

,sessions as (

select 
    e.session_guid,
    e.user_guid,
    min(e.created_at_tstamp_est) as session_start_tstamp_est,
    max(e.created_at_tstamp_est) as session_end_tstamp_est,
    {{ datediff('session_start_tstamp_est', 'session_end_tstamp_est', 'second') }} as session_duration_in_s,
       case
            when session_duration_in_s between 0 and 9 then '0s to 9s'
            when session_duration_in_s between 10 and 29 then '10s to 29s'
            when session_duration_in_s between 30 and 59 then '30s to 59s'
            when session_duration_in_s > 59 then '60s or more'
            else null
        end as session_duration_in_s_tier,
    {{row_to_columns('src_events','event_type','event_guid')}}
from src_events e
{{ dbt_utils.group_by(n=2) }}

)


SELECT
s.*,
u.FIRST_ORDER_CREATED_TSTAMP_EST as user_first_ordered_tstamp_est,
case 
    when session_end_tstamp_est < user_first_ordered_tstamp_est then 'session pre purchase'
    when session_end_tstamp_est >= user_first_ordered_tstamp_est and session_start_tstamp_est < user_first_ordered_tstamp_est then 'first purchase session'
    when session_start_tstamp_est > user_first_ordered_tstamp_est then 'returning customer'
    when user_first_ordered_tstamp_est is null then 'prospective customer'
end as user_type
from sessions s
left join dim_users u
on s.user_guid = u.user_guid