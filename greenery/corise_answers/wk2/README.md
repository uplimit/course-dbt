### What is the user repeat rate (users w/ 2+ purchases / users w/ 1+ purchase)
80%

```SQL
SELECT
    COUNT(IFF(NVL(um.user_order_count, 0) > 1, 1, NULL))
    / COUNT(IFF(NVL(um.user_order_count, 0) > 0, 1, NULL))
    AS repeat_rate
FROM tbl_user_metrics um
```


### What are good indicators of a user who will likely purchase again
As this is a hypothetical, I'm going to guess without double checking
- Likely users may be seen by higher initial order values, faster delivery times, or that created an add to cart event
- Users unlikely to repeat may be those with few URLs visits or those that used deep discount promo codes
- We don't have data around how we acquired the user (ads probably convert at a lower rate)
- We don't have data around user profile, like income level that may correlate with repeat rate


### See file structure changes and models within them for dim/fact and intermediate modeling
I added mart-level data for all the questions I expected stakeholders to ask.
I'm feeling a bit exposed on time-trend questions, but confident the data is there to answer them (just not super intuitively)
Naming conventions followed my personal preference rather than dim/fact because I've found `tbl_xx_metrics` to be better understood by less well trained coworkers
One metrics table was made at every granularity I aggregated to.  There is some duplicative descriptive data where it is probably useful (ex. `street_address` in both `tbl_shipping_metrics` and `tbl_user_metrics`)
Unless obviously a marketing-only or product team only interest, it lives in core.  No strong preference here


### See png file in same folder for DAG
It doesn't look great, but I only see one line that isn't necessary.  Open to advice.


### Added a bunch of test instances.  Here's some reasoning
- Numbers should be positive unless if it's from a DATEDIFF
- Primary keys should be unique and not null, and sometimes must reference the stg table PK too
- Foreign keys (stg_order_item) must reference the table to which they are FKs
- Margin percentage and a few others should not go above one
- And more

Although I wasn't ambitious or assumptive enough to find bad data through the tests used, I did learn that materializing as ephemeral does not play nicely with tests


### Ensure tests are passing regularly
This is dependent on the orchestration tools I have available.  At my current job, I would exclusively use dbt build so that all tests would run immediately after all model updates.  Furthermore, I would have this scheduled, perhaps hourly


### Which orders changed from a snapshot
Three orders changed from prepared to shipped status

```SQL
WITH cte_order_changes AS (
    SELECT DISTINCT order_id
    FROM snapshot_orders so
    WHERE dbt_valid_to IS NOT NULL
)

SELECT so.*
FROM snapshot_orders so
JOIN cte_order_changes oc
    ON so.order_id = oc.order_id
ORDER BY
    so.order_id
    , so.dbt_valid_from DESC
```