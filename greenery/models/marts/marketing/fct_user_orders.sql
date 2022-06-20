with

int_user_orders as (

    select * from {{ ref('int_user_orders')}}

)

select * from int_user_orders