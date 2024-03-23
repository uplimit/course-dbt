select
	PROMO_ID,
	DISCOUNT,
	STATUS
from {{ source("postgres", "promos")}}