with orders as (

    select *

    from {{ source('src_greenery', 'orders')}}

)

select * from orders