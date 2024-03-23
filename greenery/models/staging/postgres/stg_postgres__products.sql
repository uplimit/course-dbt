select
	PRODUCT_ID,
	NAME,
	PRICE,
	INVENTORY,
from {{ source("postgres", "products")}}
