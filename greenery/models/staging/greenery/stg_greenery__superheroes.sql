{{
    config(
        materialzed = 'view'
    )
}}

WITH superheroes_source AS (
    SELECT
        id
        , name
        , gender
        , eye_color
        , race
        , hair_color
        , height
        , publisher
        , skin_color
        , alignment
        , weight
        , {{ lbs_to_kgs('weight') }} AS weight_kg 
        , created_at
        , updated_at

    FROM
        {{
            source('greenery', 'superheroes')
        }}
)

, renamed_casted AS (
    SELECT
        id
        , name
        , gender
        , eye_color
        , race
        , hair_color  -- nulls are dashes and annoying for parsing
        , CASE
		    WHEN hair_color = '-' THEN 'empty'
		    ELSE hair_color
            END AS hair_color_hues
        , NULLIF(height, -99) AS height -- assume a default number if there is a NULL 
        , publisher
        , skin_color -- nulls are dashes and annoying for parsing 
        , CASE
		    WHEN skin_color = '-' THEN 'empty'
		    ELSE skin_color
            END AS skin_color_hues
        , alignment
        , NULLIF(weight, -99) AS weight_lb -- assume a default number if there is a NULL 
        , NULLIF(weight_kg, -99) AS weight_kg -- assume that the conversion to kg also needs a default number if there is a NULL
        , created_at AS created_at_utc
        , updated_at AS updated_at_utc
    FROM 
        superheroes_source  
)

SELECT 
        id
        , name
        , gender
        , eye_color
        , race
        , hair_color_hues
        , height
        , publisher
        , skin_color_hues
        , alignment
        , weight_lb
        , weight_kg
        , created_at_utc
        , updated_at_utc
FROM 
    renamed_casted
