with addresses as (

    select *

    from {{ source('src_greenery', 'addresses')}}

)

select * from addresses