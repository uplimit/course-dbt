## Week 3 

# Part 1

*1. What is our overall conversion rate?*

**62.46%**

Query:

```sql
WITH purchase_events AS 
(
  SELECT CAST(COUNT(DISTINCT session_id) AS NUMERIC) AS number_of_purchase_events
  FROM dbt_zoe_l.stg_events
  WHERE order_id IS NOT NULL
),

total_sessions AS
(
  SELECT CAST(COUNT(DISTINCT session_id) AS NUMERIC) AS number_of_unique_sessions
  FROM dbt_zoe_l.stg_events
)

SELECT
  TO_CHAR((purchase_events.number_of_purchase_events / total_sessions.number_of_unique_sessions)*100, 'fm00D00%') AS overall_conversion_rate
FROM purchase_events, total_sessions
```

*2. What is our conversion rate by product?*

Query:

```sql
SELECT * FROM dbt_zoe_l.fct_product_conversions 
```

Results:

| \|                                   |   |   |   |   |
|--------------------------------------|---|---|---|---|
| fb0e8be7-5ac4-4a76-a1fa-2cc4bf0b2d80 |   |   |   |   |
| \|                                   |   |   |   |   |
| String of pearls                     |   |   |   |   |
| \|                                   |   |   |   |   |
| 39                                   |   |   |   |   |
| \|                                   |   |   |   |   |
| 65                                   |   |   |   |   |
| \|                                   |   |   |   |   |
| 60.00%                               |   |   |   |   |
| \|                                   |   |   |   |   |
| \|                                   |   |   |   |   |
| 74aeb414-e3dd-4e8a-beef-0fa45225214d |   |   |   |   |
| \|                                   |   |   |   |   |
| Arrow Head                           |   |   |   |   |
| \|                                   |   |   |   |   |
| 35                                   |   |   |   |   |
| \|                                   |   |   |   |   |
| 64                                   |   |   |   |   |
| \|                                   |   |   |   |   |
| 54.69%                               |   |   |   |   |
| \|                                   |   |   |   |   |
| \|                                   |   |   |   |   |
| c17e63f7-0d28-4a95-8248-b01ea354840e |   |   |   |   |
| \|                                   |   |   |   |   |
| Cactus                               |   |   |   |   |
| \|                                   |   |   |   |   |
| 30                                   |   |   |   |   |
| \|                                   |   |   |   |   |
| 55                                   |   |   |   |   |
| \|                                   |   |   |   |   |
| 54.55%                               |   |   |   |   |
| \|                                   |   |   |   |   |
| \|                                   |   |   |   |   |
| b66a7143-c18a-43bb-b5dc-06bb5d1d3160 |   |   |   |   |
| \|                                   |   |   |   |   |
| ZZ Plant                             |   |   |   |   |
| \|                                   |   |   |   |   |
| 34                                   |   |   |   |   |
| \|                                   |   |   |   |   |
| 65                                   |   |   |   |   |
| \|                                   |   |   |   |   |
| 52.31%                               |   |   |   |   |
| \|                                   |   |   |   |   |
| \|                                   |   |   |   |   |
| 689fb64e-a4a2-45c5-b9f2-480c2155624d |   |   |   |   |
| \|                                   |   |   |   |   |
| Bamboo                               |   |   |   |   |
| \|                                   |   |   |   |   |
| 36                                   |   |   |   |   |
| \|                                   |   |   |   |   |
| 69                                   |   |   |   |   |
| \|                                   |   |   |   |   |
| 52.17%                               |   |   |   |   |
| \|                                   |   |   |   |   |
| \|                                   |   |   |   |   |
| be49171b-9f72-4fc9-bf7a-9a52e259836b |   |   |   |   |
| \|                                   |   |   |   |   |
| Monstera                             |   |   |   |   |
| \|                                   |   |   |   |   |
| 25                                   |   |   |   |   |
| \|                                   |   |   |   |   |
| 49                                   |   |   |   |   |
| \|                                   |   |   |   |   |
| 51.02%                               |   |   |   |   |
| \|                                   |   |   |   |   |
| \|                                   |   |   |   |   |
| b86ae24b-6f59-47e8-8adc-b17d88cbd367 |   |   |   |   |
| \|                                   |   |   |   |   |
| Calathea Makoyana                    |   |   |   |   |
| \|                                   |   |   |   |   |
| 27                                   |   |   |   |   |
| \|                                   |   |   |   |   |
| 53                                   |   |   |   |   |
| \|                                   |   |   |   |   |
| 50.94%                               |   |   |   |   |
| \|                                   |   |   |   |   |
| \|                                   |   |   |   |   |
| 579f4cd0-1f45-49d2-af55-9ab2b72c3b35 |   |   |   |   |
| \|                                   |   |   |   |   |
| Rubber Plant                         |   |   |   |   |
| \|                                   |   |   |   |   |
| 28                                   |   |   |   |   |
| \|                                   |   |   |   |   |
| 56                                   |   |   |   |   |
| \|                                   |   |   |   |   |
| 50.00%                               |   |   |   |   |
| \|                                   |   |   |   |   |
| \|                                   |   |   |   |   |
| 615695d3-8ffd-4850-bcf7-944cf6d3685b |   |   |   |   |
| \|                                   |   |   |   |   |
| Aloe Vera                            |   |   |   |   |
| \|                                   |   |   |   |   |
| 32                                   |   |   |   |   |
| \|                                   |   |   |   |   |
| 65                                   |   |   |   |   |
| \|                                   |   |   |   |   |
| 49.23%                               |   |   |   |   |
| \|                                   |   |   |   |   |
| \|                                   |   |   |   |   |
| 35550082-a52d-4301-8f06-05b30f6f3616 |   |   |   |   |
| \|                                   |   |   |   |   |
| Devil's Ivy                          |   |   |   |   |
| \|                                   |   |   |   |   |
| 22                                   |   |   |   |   |
| \|                                   |   |   |   |   |
| 45                                   |   |   |   |   |
| \|                                   |   |   |   |   |
| 48.89%                               |   |   |   |   |
| \|                                   |   |   |   |   |
| \|                                   |   |   |   |   |
| 5ceddd13-cf00-481f-9285-8340ab95d06d |   |   |   |   |
| \|                                   |   |   |   |   |
| Majesty Palm                         |   |   |   |   |
| \|                                   |   |   |   |   |
| 33                                   |   |   |   |   |
| \|                                   |   |   |   |   |
| 69                                   |   |   |   |   |
| \|                                   |   |   |   |   |
| 47.83%                               |   |   |   |   |
| \|                                   |   |   |   |   |
| \|                                   |   |   |   |   |
| a88a23ef-679c-4743-b151-dc7722040d8c |   |   |   |   |
| \|                                   |   |   |   |   |
| Jade Plant                           |   |   |   |   |
| \|                                   |   |   |   |   |
| 22                                   |   |   |   |   |
| \|                                   |   |   |   |   |
| 46                                   |   |   |   |   |
| \|                                   |   |   |   |   |
| 47.83%                               |   |   |   |   |
| \|                                   |   |   |   |   |
| \|                                   |   |   |   |   |
| 55c6a062-5f4a-4a8b-a8e5-05ea5e6715a3 |   |   |   |   |
| \|                                   |   |   |   |   |
| Philodendron                         |   |   |   |   |
| \|                                   |   |   |   |   |
| 30                                   |   |   |   |   |
| \|                                   |   |   |   |   |
| 63                                   |   |   |   |   |
| \|                                   |   |   |   |   |
| 47.62%                               |   |   |   |   |
| \|                                   |   |   |   |   |
| \|                                   |   |   |   |   |
| e706ab70-b396-4d30-a6b2-a1ccf3625b52 |   |   |   |   |
| \|                                   |   |   |   |   |
| Fiddle Leaf Fig                      |   |   |   |   |
| \|                                   |   |   |   |   |
| 28                                   |   |   |   |   |
| \|                                   |   |   |   |   |
| 59                                   |   |   |   |   |
| \|                                   |   |   |   |   |
| 47.46%                               |   |   |   |   |
| \|                                   |   |   |   |   |
| \|                                   |   |   |   |   |
| 64d39754-03e4-4fa0-b1ea-5f4293315f67 |   |   |   |   |
| \|                                   |   |   |   |   |
| Spider Plant                         |   |   |   |   |
| \|                                   |   |   |   |   |
| 28                                   |   |   |   |   |
| \|                                   |   |   |   |   |
| 59                                   |   |   |   |   |
| \|                                   |   |   |   |   |
| 47.46%                               |   |   |   |   |
| \|                                   |   |   |   |   |
| \|                                   |   |   |   |   |
| 37e0062f-bd15-4c3e-b272-558a86d90598 |   |   |   |   |
| \|                                   |   |   |   |   |
| Dragon Tree                          |   |   |   |   |
| \|                                   |   |   |   |   |
| 29                                   |   |   |   |   |
| \|                                   |   |   |   |   |
| 62                                   |   |   |   |   |
| \|                                   |   |   |   |   |
| 46.77%                               |   |   |   |   |
| \|                                   |   |   |   |   |
| \|                                   |   |   |   |   |
| 5b50b820-1d0a-4231-9422-75e7f6b0cecf |   |   |   |   |
| \|                                   |   |   |   |   |
| Pilea Peperomioides                  |   |   |   |   |
| \|                                   |   |   |   |   |
| 28                                   |   |   |   |   |
| \|                                   |   |   |   |   |
| 60                                   |   |   |   |   |
| \|                                   |   |   |   |   |
| 46.67%                               |   |   |   |   |
| \|                                   |   |   |   |   |
| \|                                   |   |   |   |   |
| d3e228db-8ca5-42ad-bb0a-2148e876cc59 |   |   |   |   |
| \|                                   |   |   |   |   |
| Money Tree                           |   |   |   |   |
| \|                                   |   |   |   |   |
| 26                                   |   |   |   |   |
| \|                                   |   |   |   |   |
| 56                                   |   |   |   |   |
| \|                                   |   |   |   |   |
| 46.43%                               |   |   |   |   |
| \|                                   |   |   |   |   |
| \|                                   |   |   |   |   |
| c7050c3b-a898-424d-8d98-ab0aaad7bef4 |   |   |   |   |
| \|                                   |   |   |   |   |
| Orchid                               |   |   |   |   |
| \|                                   |   |   |   |   |
| 34                                   |   |   |   |   |
| \|                                   |   |   |   |   |
| 75                                   |   |   |   |   |
| \|                                   |   |   |   |   |
| 45.33%                               |   |   |   |   |
| \|                                   |   |   |   |   |
| \|                                   |   |   |   |   |
| 05df0866-1a66-41d8-9ed7-e2bbcddd6a3d |   |   |   |   |
| \|                                   |   |   |   |   |
| Bird of Paradise                     |   |   |   |   |
| \|                                   |   |   |   |   |
| 27                                   |   |   |   |   |
| \|                                   |   |   |   |   |
| 60                                   |   |   |   |   |
| \|                                   |   |   |   |   |
| 45.00%                               |   |   |   |   |
| \|                                   |   |   |   |   |
| \|                                   |   |   |   |   |
| 843b6553-dc6a-4fc4-bceb-02cd39af0168 |   |   |   |   |
| \|                                   |   |   |   |   |
| Ficus                                |   |   |   |   |
| \|                                   |   |   |   |   |
| 29                                   |   |   |   |   |
| \|                                   |   |   |   |   |
| 68                                   |   |   |   |   |
| \|                                   |   |   |   |   |
| 42.65%                               |   |   |   |   |
| \|                                   |   |   |   |   |
| \|                                   |   |   |   |   |
| 80eda933-749d-4fc6-91d5-613d29eb126f |   |   |   |   |
| \|                                   |   |   |   |   |
| Pink Anthurium                       |   |   |   |   |
| \|                                   |   |   |   |   |
| 31                                   |   |   |   |   |
| \|                                   |   |   |   |   |
| 74                                   |   |   |   |   |
| \|                                   |   |   |   |   |
| 41.89%                               |   |   |   |   |
| \|                                   |   |   |   |   |
| \|                                   |   |   |   |   |
| e2e78dfc-f25c-4fec-a002-8e280d61a2f2 |   |   |   |   |
| \|                                   |   |   |   |   |
| Boston Fern                          |   |   |   |   |
| \|                                   |   |   |   |   |
| 26                                   |   |   |   |   |
| \|                                   |   |   |   |   |
| 63                                   |   |   |   |   |
| \|                                   |   |   |   |   |
| 41.27%                               |   |   |   |   |
| \|                                   |   |   |   |   |
| \|                                   |   |   |   |   |
| bb19d194-e1bd-4358-819e-cd1f1b401c0c |   |   |   |   |
| \|                                   |   |   |   |   |
| Birds Nest Fern                      |   |   |   |   |
| \|                                   |   |   |   |   |
| 33                                   |   |   |   |   |
| \|                                   |   |   |   |   |
| 80                                   |   |   |   |   |
| \|                                   |   |   |   |   |
| 41.25%                               |   |   |   |   |
| \|                                   |   |   |   |   |
| \|                                   |   |   |   |   |
| e5ee99b6-519f-4218-8b41-62f48f59f700 |   |   |   |   |
| \|                                   |   |   |   |   |
| Peace Lily                           |   |   |   |   |
| \|                                   |   |   |   |   |
| 27                                   |   |   |   |   |
| \|                                   |   |   |   |   |
| 67                                   |   |   |   |   |
| \|                                   |   |   |   |   |
| 40.30%                               |   |   |   |   |
| \|                                   |   |   |   |   |
| \|                                   |   |   |   |   |
| e8b6528e-a830-4d03-a027-473b411c7f02 |   |   |   |   |
| \|                                   |   |   |   |   |
| Snake Plant                          |   |   |   |   |
| \|                                   |   |   |   |   |
| 29                                   |   |   |   |   |
| \|                                   |   |   |   |   |
| 73                                   |   |   |   |   |
| \|                                   |   |   |   |   |
| 39.73%                               |   |   |   |   |
| \|                                   |   |   |   |   |
| \|                                   |   |   |   |   |
| e18f33a6-b89a-4fbc-82ad-ccba5bb261cc |   |   |   |   |
| \|                                   |   |   |   |   |
| Ponytail Palm                        |   |   |   |   |
| \|                                   |   |   |   |   |
| 28                                   |   |   |   |   |
| \|                                   |   |   |   |   |
| 71                                   |   |   |   |   |
| \|                                   |   |   |   |   |
| 39.44%                               |   |   |   |   |
| \|                                   |   |   |   |   |
| \|                                   |   |   |   |   |
| 6f3a3072-a24d-4d11-9cef-25b0b5f8a4af |   |   |   |   |
| \|                                   |   |   |   |   |
| Alocasia Polly                       |   |   |   |   |
| \|                                   |   |   |   |   |
| 21                                   |   |   |   |   |
| \|                                   |   |   |   |   |
| 54                                   |   |   |   |   |
| \|                                   |   |   |   |   |
| 38.89%                               |   |   |   |   |
| \|                                   |   |   |   |   |
| \|                                   |   |   |   |   |
| 58b575f2-2192-4a53-9d21-df9a0c14fc25 |   |   |   |   |
| \|                                   |   |   |   |   |
| Angel Wings Begonia                  |   |   |   |   |
| \|                                   |   |   |   |   |
| 24                                   |   |   |   |   |
| \|                                   |   |   |   |   |
| 62                                   |   |   |   |   |
| \|                                   |   |   |   |   |
| 38.71%                               |   |   |   |   |
| \|                                   |   |   |   |   |
| \|                                   |   |   |   |   |
| 4cda01b9-62e2-46c5-830f-b7f262a58fb1 |   |   |   |   |
| \|                                   |   |   |   |   |
| Pothos                               |   |   |   |   |
| \|                                   |   |   |   |   |
| 21                                   |   |   |   |   |
| \|                                   |   |   |   |   |
| 64                                   |   |   |   |   |
| \|                                   |   |   |   |   |
| 32.81%                               |   |   |   |   |
| \|                                   |   |   |   |   |

# Part 2

*Create a macro to simplify part of a model(s).*

The macro `event_type` is used in `product.intermediate.int_session_events_agg` to aggregate event types. 

# Part 3

*We’re starting to think about granting permissions to our dbt models in our postgres database so that other roles can have access to them.*

Please see the `dbt_project.yml` file! 

# Part 4

*After learning about dbt packages, we want to try one out and apply some macros or tests.*

Please see the `packages.yml` file - I used `dbt_utils` and `dbt_expectations` for week 1 & 2 projects (mainly for tests and the group by function), and `codegen` for the week 3 project (to generate model yml files!). 
