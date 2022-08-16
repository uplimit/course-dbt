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
        , height
        , publisher
        , skin_color -- nulls are dashes and annoying for parsing 
        , CASE
		    WHEN skin_color = '-' THEN 'empty'
		    ELSE skin_color
            END AS skin_color_hues
        , alignment
        , weight
        , created_at
        , updated_at
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
        , weight
        , created_at
        , updated_at
FROM 
    renamed_casted
