with promos as (

    select *

    from {{ source('src_greenery', 'promos')}}

)

select * from promos