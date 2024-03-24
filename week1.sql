select count(*) from mushrooms;

select * from stg_superheroes;

select name, weight from stg_superheroes where weight < 0;

select name, count(*) as total from stg_superheroes 
group by name
order by total desc;


select 
    USER_ID,
	FIRST_NAME,
	LAST_NAME,
	EMAIL,
	PHONE_NUMBER,
	CREATED_AT,
	UPDATED_AT,
	ADDRESS_ID,
from raw.public.users;

select * from DEV_DB.DBT_PBASHYALNMDPORG.STG_POSTGRES__USERS;


select
	PROMO_ID,
	DISCOUNT,
	STATUS
from raw.public.promos;

select * from DEV_DB.DBT_PBASHYALNMDPORG.STG_POSTGRES__promos;

select
	PRODUCT_ID,
	NAME,
	PRICE,
	INVENTORY,
from RAW.PUBLIC.PRODUCTS;

select * from DEV_DB.DBT_PBASHYALNMDPORG.STG_POSTGRES__products;

select
	ORDER_ID,
	USER_ID,
	PROMO_ID,
	ADDRESS_ID,
	CREATED_AT,
	ORDER_COST,
	SHIPPING_COST,
	ORDER_TOTAL,
	TRACKING_ID,
	SHIPPING_SERVICE,
	ESTIMATED_DELIVERY_AT,
	DELIVERED_AT,
	STATUS,
from RAW.PUBLIC.ORDERS;

select * from DEV_DB.DBT_PBASHYALNMDPORG.STG_POSTGRES__orders;

select
    ORDER_ID,
	PRODUCT_ID
	QUANTITY,
from RAW.PUBLIC.ORDER_ITEMS;

select * from DEV_DB.DBT_PBASHYALNMDPORG.STG_POSTGRES__order_items;

select
	EVENT_ID,
	SESSION_ID,
	USER_ID,
	PAGE_URL,
	CREATED_AT,
	EVENT_TYPE,
	ORDER_ID,
	PRODUCT_ID,
from RAW.PUBLIC.EVENTS;

select * from DEV_DB.DBT_PBASHYALNMDPORG.STG_POSTGRES__events;

select
    ADDRESS_ID,
	ADDRESS,
	ZIPCODE,
	STATE,
	COUNTRY,
from RAW.PUBLIC.ADDRESSES;

select * from DEV_DB.DBT_PBASHYALNMDPORG.STG_POSTGRES__ADDRESSES;

-- ### How many users do we have?
select count(*) from DEV_DB.DBT_PBASHYALNMDPORG.STG_POSTGRES__USERS;
-- 130

-- ### On average, how many orders do we receive per hour?
select date_part(HOUR, created_at) as hour, count(*) from DEV_DB.DBT_PBASHYALNMDPORG.STG_POSTGRES__orders
group by 1
order by hour;

select avg(total_hour) from (
    select  count(*) as total_hour from DEV_DB.DBT_PBASHYALNMDPORG.STG_POSTGRES__orders
    group by date_part(HOUR, created_at)
);
-- 15.041667

--- ### On average, how long does an order take from being placed to being delivered?
select avg(delivery_time) from (
select timediff(hour, created_at, delivered_at) as delivery_time from DEV_DB.DBT_PBASHYALNMDPORG.STG_POSTGRES__orders 
where status = 'delivered'
order by created_at
);


-- ### How many users have only made one purchase? Two purchases? Three+ purchases?

select users.user_id, count(*) from 
DEV_DB.DBT_PBASHYALNMDPORG.STG_POSTGRES__users as users
join 
DEV_DB.DBT_PBASHYALNMDPORG.STG_POSTGRES__orders as orders
on users.user_id = orders.user_id
group by users.user_id
-- having count(*) = 1
-- having count(*) = 2
having count(*) >= 3
order by count(*) desc;

-- ### On average, how many unique sessions do we have per hour?
select avg(hour_count)
from (
select session_id, date_part(hour, created_at) as hours, count(*) as hour_count from DEV_DB.DBT_PBASHYALNMDPORG.STG_POSTGRES__events
group by session_id, date_part(hour, created_at)
);