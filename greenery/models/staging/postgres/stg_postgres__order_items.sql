select
    ORDER_ID,
	PRODUCT_ID
	QUANTITY,
from {{source("postgres", "order_items")}}