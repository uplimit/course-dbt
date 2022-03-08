SELECT 
user_id AS user_id,
first_name AS first_name,
last_name AS last_name,
email AS email,
phone_number AS phone_number,
created_at AS created_at,
updated_at AS updated_at,
address_id AS address_id
FROM {{ source('greenery', 'users') }}
