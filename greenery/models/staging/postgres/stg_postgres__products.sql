select 
	PRODUCT_ID,
	NAME as PRODUCT_NAME,
	PRICE,
	INVENTORY
from {{source('postgres','products')}}