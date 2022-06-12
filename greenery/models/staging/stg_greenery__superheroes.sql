with

source as (

    select * from {{ source('greenery', 'superheroes') }}

),

renamed as (
    select 
        id,
        name,
        gender,
        eye_color,
        race,
        hair_color,
        height,
        publisher,
        skin_color,
        alignment,
        weight,
        created_at,
        updated_at
    from source
)

select * from renamed
