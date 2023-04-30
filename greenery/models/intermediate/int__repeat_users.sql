 {{
  config(
    materialized='table'
  )
}}

WITH repeat_users AS (
    SELECT
          iuo.user_id
        , CASE
            WHEN iuo.number_of_orders > 1 THEN TRUE
            ELSE FALSE
          END AS is_repeat_user
    FROM {{ ref('int__user_orders') }} AS iuo
)

SELECT 
    * 
FROM repeat_users