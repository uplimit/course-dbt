with sessions as (

    select
        *
    from
        {{ ref('fact_sessions') }}

)

select
    count_if(checkout_in_session > 0) as order_sessions,
    count(session_id) as total_sessions,
    round(order_sessions / total_sessions, 3) as conversion_rate
from
sessions