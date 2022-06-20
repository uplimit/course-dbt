{{
    config(
        MATERIALIZED='table'
    )
}}



    select 
    user_id,
    sum(discount) acu_discount

    from {{ref('init_disccount_counts')}}
group by 1


