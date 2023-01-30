with purchasers as (

    select 
        *
    from
        {{ ref('dim_users') }}
    where
        n_orders > 0

)

select
    count_if(n_orders > 1) as repeat_purchasers,
    count(user_id) as all_purchasers,
    round(repeat_purchasers / all_purchasers, 3) as repeat_purchase_rate
from
    purchasers