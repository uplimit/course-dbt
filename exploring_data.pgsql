
with user_sessions as (

    select
        user_guid
        , session_guid
        , min(created_at_utc) as session_start
        , max(created_at_utc) as session_end
        , sum(case when event_type = 'page_view' then 1 else 0 end) as page_view
        , sum(case when event_type = 'add_to_cart' then 1 else 0 end) as add_to_cart
        , sum(case when event_type = 'checkout' then 1 else 0 end) as checkout
        , sum(case when event_type = 'package_shipped' then 1 else 0 end) as package_shipped
    from dbt_jason_d.stg_public__events
    where session_guid = 'a646b9aa-0044-4fbd-8bae-a1018f5d4ace'
    group by 1,2

)

select
    user_sessions.*
    , session_end - session_start as time_on_site
from user_sessions;



select * from dbt_jas

