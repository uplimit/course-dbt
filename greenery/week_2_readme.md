## Part 1. Models
_What is our user repeat rate?_

80% (0.798)

```sql
    WITH orders_per_user AS (
        SELECT 
        u.user_id,
        COUNT(DISTINCT o.order_id) AS order_count

    FROM DEV_DB.DBT_ANNBARD12.STG_USERS u
    JOIN DEV_DB.DBT_ANNBARD12.STG_ORDERS o
    ON u.user_id = o.user_id

    GROUP BY 1),

    more_than_two_orders AS (
        SELECT
        CASE 
        WHEN order_count >= 2 THEN 'more_than_two_orders'
        ELSE 'others' END 
        AS orders,
        COUNT(DISTINCT user_id) nr_users

        FROM orders_per_user

        GROUP BY 1)

        SELECT
        orders,
        nr_users,
        nr_users / SUM(nr_users) OVER ()

        FROM more_than_two_orders 
```

_What are good indicators of a user who will likely purchase again? What about indicators of users who are likely NOT to purchase again? If you had more data, what features would you want to look into to answer this question?_

    Good indicators of whether users will purchase again are if they visit the site often, have made purchases in the past, interact with the website and add products to their cart.

    Indicators that users are not likely to purchase are if they haveven't vitisted the webiste in more than a certain amount of months, bought anything in a certain amount of months, unsubscribed from a mailing list.

    If I could analyze more data, I would check which users are part of a loyalty program, which users are subscribed to a mailing list.

_Explain the marts models you added. Why did you organize the models in the way you did?_
    It took me quite some time to think through how to organize the models. I thought it would not be super difficult, but in practice I wanted to make sure I did not duplicate logic and with the three different marts there is sometimes overlap about which models are needed where. I also first created the dim_users model in the core mart, but then realized that some of the info it contains is maybe more needed in marketing. That is why there is not core users model. I also have a bit of an overlap in the marketing mart, where I have an intermediate ordered_products model and almost this same model is in the products mart because I think they would also be interested in this data. However, I think it's not ideal that some logic is copied and I wasn't sure what to do in this case.

_Use the dbt docs to visualize your model DAGs to ensure the model layers make sense_
The image will be in the thread in slack.

## Part 2. Tests
_What assumptions are you making about each model? (i.e. why are you adding each test?)_
I assumed that all the _id fields are unique and not null since they should be primary keys and foreign keys. I also assumed that the order values should not be null and should be positive values.

_Did you find any “bad” data as you added and ran tests on your models? How did you go about either cleaning the data in the dbt model or adjusting your assumptions/tests?_
When running the tests, I saw that the order amounts can be, quantities and products ordered could be null so I added COALESCE(field, 0) to those columns and this fixed the tests.

I also saw that some id's in my models failed the uniqueness tests - I am not sure if that is something wrong with the data or if I am doing something incorrectly. I added DISTINCT to some of the models to remove duplicates, but I saw that some unqiqueness tests still fail.

_Your stakeholders at Greenery want to understand the state of the data each day. Explain how you would ensure these tests are passing regularly and how you would alert stakeholders about bad data getting through._
I would use an orchestration tool like Airflow to send alerts about freshness of the data, and to monitor daily tests. These alerts could be sent to a separate alerts channel on Slack so that the Data Team is always informed about any failures.

## Part 3. dbt Snapshots
_Which orders changed from week 1 to week 2?_

The following order IDs changed:
914b8929-e04a-40f8-86ee-357f2be3a2a2
939767ac-357a-4bec-91f8-a7b25edd46c9
05202733-0e17-4726-97c2-0520c024ab85