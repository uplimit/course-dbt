    select 
        PROMO_ID,
        DISCOUNT,
        STATUS AS PROMO_STATUS
    from {{source('postgres','promos')}}