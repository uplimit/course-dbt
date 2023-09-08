What is our overall conversion rate?
select
    count(distinct session_id)  as sessions,
    count(distinct order_id)    as orders,
    orders/sessions * 100       as conversion_rate
from fct_conversion;


What is our conversion rate by product?

select
    product_id,
    count(distinct session_id) as sessions,
    count(distinct order_id)    as orders,
    orders/sessions * 100            as conversion_rate
from fct_conversion
group by 1;