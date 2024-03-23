select
    ADDRESS_ID,
	ADDRESS,
	ZIPCODE,
	STATE,
	COUNTRY,
from {{ source("postgres", "addresses" )}}