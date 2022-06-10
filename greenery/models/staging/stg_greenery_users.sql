with users as (

    select *

    from {{ source('src_greenery', 'users')}}

)

select * from users