with

int_user_dimensions as (

    select * from {{ ref('int_user_dimensions_joined')}}

),

int_orders as (

    select * from {{ ref('int_orders_promos_joined')}}

),

final as (

    select

        -- user dimensions
        int_user_dimensions.user_guid
        , int_user_dimensions.first_name
        , int_user_dimensions.last_name
        , int_user_dimensions.phone_number
        , int_user_dimensions.email
        , int_user_dimensions.user_address
        , int_user_dimensions.user_zip_code
        , int_user_dimensions.user_state
        , int_user_dimensions.user_country

        -- order details
        , case when max(promo_id) is null then 0 
               else 1 
          end                            as promo_user
        , sum(promo_discount)            as total_promo_discount
        , count(distinct order_guid)     as total_orders
        , sum(order_total_spend)         as total_spend
        , avg(order_total_spend)         as avg_spend
        , sum(order_total_items)         as total_items
        , avg(order_total_items)         as avg_basket_size
        , max(int_orders.created_at_utc) as last_order_date
    
    from int_user_dimensions
    left join int_orders using(user_guid)

    group by 1,2,3,4,5,6,7,8,9
)

select * from final