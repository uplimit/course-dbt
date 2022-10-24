

****1: What is our overall conversion rate?**
**answer:** 62.5%
            'select
                count(distinct session_guid) as total_sessions,
                count(distinct case when order_guid is not null then session_guid else null end) as conversions,
                conversions/total_sessions
            from dev_db.dbt_bavery.src_events'


****2:What is our conversion rate by product?**
**answer:** Query for conversion rate by product

            with products_ordered as (
                select
                    oli.order_guid,
                    p.product_name
                from dev_db.dbt_bavery.src_order_items oli
                left join dev_db.dbt_bavery.dim_products p
                on oli.product_guid = p.product_guid
                order by oli.order_guid

            )

            ,converted_sessions as (
                select
                    pd.product_name,
                    session_guid
                from dev_db.dbt_bavery.src_events e
                join products_ordered pd
                on e.order_guid = pd.order_guid
                group by 1,2

                )
                
            ,all_sessions as  (   
                select 
                    product_name,
                    session_guid
                from dev_db.dbt_bavery.fact_page_views e
                group by 1,2
            )

            select
                s.product_name,
                count(distinct s.session_guid) as all_sessions,
                count(distinct cs.session_guid) as converted_sessions,
                converted_sessions/all_sessions as conversion_rate
            from all_sessions s
            left join converted_sessions cs --- just in case theres some weirdness where prodcuts are bought but 
                on s.product_name = cs.product_name
                and s.session_guid = cs.session_guid
            group by 1
            order by 4 desc



****3:Why some products convert higher than others?**
*answer:** Page load times, different images, the product itself may require more thought so someone may come to the site more times before buying,  


****4:What orders changed from week 2 to 3?**
*answer:**
e24985f3-2fb3-456e-a1aa-aaf88f490d70
8385cfcd-2b3f-443a-a676-9756f7eb5404
5741e351-3124-4de7-9dff-01a448e7dfd4

                select distinct order_guid
                from dev_db.dbt_bavery.orders_ss
                where dbt_valid_from::Date = '2022-10-24'  or dbt_valid_to::Date ='2022-10-24' 