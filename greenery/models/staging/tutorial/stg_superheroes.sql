{{
  config(
    materialized='table'
  )
}}

SELECT 
    id AS superhero_id,
    name,
    gender,
    eye_color,
    race,
    hair_color,
    NULLIF(height, -99) as height,
    publisher,
    skin_color,
    alignment,
    NULLIF(weight, -99) as weight_lbs,
    {{ lbs_to_kgs('weight') }} AS weight_kg
FROM {{ source('tutorial', 'superheroes') }}
