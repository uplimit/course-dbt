with addresses as (
    select * from {{ source('src_addresses', 'addresses')}}
    ),

    final as (
        select
            address_id,
            address,
            zipcode,
            state,
            country
        from addresses
    )

    select * from final