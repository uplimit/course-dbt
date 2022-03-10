select 
    promo_id,
    discount,
    status

from {{ source('greenery','promos')}}