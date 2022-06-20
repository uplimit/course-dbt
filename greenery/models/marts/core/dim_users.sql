with

user_dimensions_joined as (

    select * from {{ ref('int_user_dimensions_joined')}}

)

select * from user_dimensions_joined