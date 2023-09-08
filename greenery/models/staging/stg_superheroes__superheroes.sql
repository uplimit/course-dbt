with superheroes as (
    select * from {{ source('greenery', 'superheroes') }}
),

final as (
    select
        id
        ,name
        ,gender
        ,eye_color
        ,race
        ,hair_color
        ,height
        ,publisher
        ,skin_color
        ,alignment
        ,weight
        ,created_at as created_at_utc
        ,updated_at as updated_at_utc
    from superheroes
)

select * from final