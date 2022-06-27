
*** PART 1 
** What is ur overall cnversion rate?

````sql
with conversion_rate as 
( 
select
product_id,
name,
cast(count(distinct (case when event_type='add_to_cart' then session_id end)) as float) as check_out,
cast(count(distinct session_id)  as float) as sessions

from 
dbt.dbt_sofia.stg_greenery_events
left join dbt.dbt_sofia.stg_greenery_products using( product_id)

group by 1,2 )

select 
product_id,
name,
sum(check_out)/sum(sessions) as cr  from conversion_rate
group by 1,2
````
** What is ur overall cnversion rate by product?
````slq

with conversion_rate as 
( 
select
product_id,
name,
cast(count(distinct (case when event_type='add_to_cart' then session_id end)) as float) as check_out,
cast(count(distinct session_id)  as float) as sessions

from 
dbt.dbt_sofia.stg_greenery_events
left join dbt.dbt_sofia.stg_greenery_products using( product_id)

group by 1,2 )

select 
product_id,
name,
sum(check_out)/sum(sessions) as cr  from conversion_rate
group by 1,2
````

<img width="186" alt="image" src="https://user-images.githubusercontent.com/106842349/175751123-36ff4aab-88cc-40b7-9bb6-bc2fd5938bdf.png">

*** PART 2 
macro used in models/mart/product/event_type_per_sesssion.sql 
````sql
{% macro get_column_values(column_name, relation) %}

{% set relation_query %}
select distinct
{{ column_name }}
from {{ relation }}
order by 1
{% endset %}

{% set results = run_query(relation_query) %}

{% if execute %}
{% set results_list = results.columns[0].values() %}
{% else %}
{% set results_list = [] %}
{% endif %}

{{ return(results_list) }}

{% endmacro %}


{% macro get_payment_methods() %}

{{ return(get_column_values('event_type', ref('stg_greenery_events'))) }}

{% endmacro %}
````
***PART 4
macro used in models/mart/product/event_type_per_sesssion_version2.sql 
````sql
{%- set event_types = dbt_utils.get_column_values(
    table=ref('stg_greenery_events'),
    column='event_type'
) -%}

select
session_id,
{%- for event_type in event_types %}
sum(case when event_type = '{{event_type}}' then 1 end) as {{event_type}}_count
{%- if not loop.last %},{% endif -%}
{% endfor %}
from {{ ref('stg_greenery_events') }}
group by 1

````

### Resources:
- Learn more about dbt [in the docs](https://docs.getdbt.com/docs/introduction)
- Check out [Discourse](https://discourse.getdbt.com/) for commonly asked questions and answers
- Join the [chat](https://community.getdbt.com/) on Slack for live discussions and support
- Find [dbt events](https://events.getdbt.com) near you
- Check out [the blog](https://blog.getdbt.com/) for the latest news on dbt's development and best practices
