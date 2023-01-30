with users as (

    select
        *
    from
        {{ ref('stg_postgres__users') }}

),

addresses as (

    select 
        *
    from    
        {{ ref('stg_postgres__addresses') }}

),

user_orders_agg as (

    select
        user_id,
        count(order_id) as n_orders,
        min(created_at_utc) as first_order_placed_at,
        max(created_at_utc) as most_recent_order_placed_at,
        sum(order_cost_usd) as lifetime_value
    from
        {{ ref('stg_postgres__orders') }}
    group by 1

),

final as (

    select
        users.user_id,
        users.first_name,
        users.last_name,
        users.full_name,
        users.email,
        users.phone_number,
        users.created_at_utc,
        users.updated_at_utc,
        addresses.address,
        addresses.zipcode,
        addresses.state,
        addresses.country,
        coalesce(user_orders_agg.n_orders, 0) as n_orders,
        user_orders_agg.first_order_placed_at,
        user_orders_agg.most_recent_order_placed_at,
        user_orders_agg.lifetime_value
    from
        users
    left join 
        addresses using(address_id)
    left join 
        user_orders_agg using(user_id)

)

select * from final
