with

int_user_sessions_agg as (

    select * from {{ ref('int_user_sessions_agg')}}

)

select * from int_user_sessions_agg