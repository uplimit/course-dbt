with

staged_products as (

    select * from {{ ref('stg_public__products')}}

)

select * from staged_products