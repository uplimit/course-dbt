with users as (

    select
        user_id
    from
        {{ ref('stg_postgres__users') }}

)

select
    count(user_id)
from
    users