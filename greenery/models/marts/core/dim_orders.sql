with

intermediate_orders as (

    select * from {{ ref('int_orders')}}

)

select * from intermediate_orders