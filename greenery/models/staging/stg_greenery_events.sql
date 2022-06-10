with events as (

    select *

    from {{ source('src_greenery', 'events')}}

)

select * from events