with product_sessions as (

    select
        *
    from
        {{ ref('fact_product_sessions') }}

)

select 
    product_name,
    count_if(event_type='checkout') as checkout_sessions,
    count(session_id) as total_sessions,
    round(checkout_sessions / total_sessions, 2) as conversion_rate
from
    fact_product_sessions
group by 1