{{
  config(
    materialized='table'
  )
}}

SELECT 
    id AS superhero_id
    , name
    , gender
    , eye_color
    , race
    , hair_color
    , NULLIF(height, -99) AS height -- assume a default number if there is a null 
    , publisher
    , skin_color
    , alignment
    , NULLIF(weight, -99) AS weight
    , {{ lbs_to_kgs('weight') }} AS weight_kg
FROM 
  {{ 
    source('tutorial', 'superheroes') 
  }}

{{
  config(
    materialized='table'
  )
}}
