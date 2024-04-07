select product_id, name, price, inventory from {{ source("postgres", "products") }}
