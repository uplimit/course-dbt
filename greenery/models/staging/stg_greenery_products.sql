with products as (

    select *

    from {{ source('src_greenery', 'products')}}

)

select * from products