1. What is our user repeat rate?

   - Repeat Rate = Users who purchased 2 or more times / users who purchased

   Query:

   ```sql
   select count_if(is_repeat_buyer) / count(*)
   from fct_user_orders
   where is_buyer = TRUE
   ```

   Result: 0.798387

2. What are good indicators of a user who will likely purchase again? What about indicators of users who are likely NOT to purchase again? If you had more data, what features would you want to look into to answer this question?

   - NOTE: This is a hypothetical question vs. something we can analyze in our Greenery data set. Think about what exploratory analysis you would do to approach this question.

   Users who have ordered the same item multiple times are likely to do so again, especially if the repeat orders are spaced out over time. This can indicate the product is an essential that has run out, and the customer is restocking. We can perform an analysis of the per-user order rate and group by different products.

   More generally, we can imagine that users who frequently order from us, without regard to the specific product, are more likely to order again. This suggests company loyalty (compared to product loyalty).

   We can also conduct group studies and make inferences about specific users. For example, we can draw conclusions about various age groups across various product categories. This would require modeling those additional dimensions.

3. Explain the product mart models you added. Why did you organize the models in the way you did?

   I added a product page views model in anticipation of a common business question: How are various products performing? We can now answer this by analyzing product events: page views, times added to cart, number of checkouts, and whether the product shipped. We can analyze the popularity of a product, how easy it is order (via session length), and we can check the health of the fulfillment pipeline (whether the product shipped).

4. What assumptions are you making about each model? (i.e. why are you adding each test?)

   I am primarily testing primary keys, for uniqueness and being non-null. These are universal traits that do not require an understanding of the fields according to the business.

5. Did you find any “bad” data as you added and ran tests on your models? How did you go about either cleaning the data in the dbt model or adjusting your assumptions/tests?

   Yes, I found data that failed my tests, but the failures actually just indicated that I misspecified my tests. I corrected the tests and they passed.

6. Your stakeholders at Greenery want to understand the state of the data each day. Explain how you would ensure these tests are passing regularly and how you would alert stakeholders about bad data getting through.

   It seems that dbt is a great tool to incorporate into a CI/CD pipeline. For example, we can schedule a job to incrementally build models and run tests each day. We can hook into any test failures (and cancel the rest of the pipeline) with email or Slack notifications.

7. Which products had their inventory change from week 1 to week 2?

   The following existing products had their inventories change to the listed values:

   | PRODUCT_ID                           | INVENTORY |
   | ------------------------------------ | --------- |
   | 4cda01b9-62e2-46c5-830f-b7f262a58fb1 | 40        |
   | 55c6a062-5f4a-4a8b-a8e5-05ea5e6715a3 | 51        |
   | be49171b-9f72-4fc9-bf7a-9a52e259836b | 77        |
   | fb0e8be7-5ac4-4a76-a1fa-2cc4bf0b2d80 | 58        |
   | fb0e8be7-5ac4-4a76-a1fa-2cc4bf0b2d80 | 10        |
   | 4cda01b9-62e2-46c5-830f-b7f262a58fb1 | 20        |
   | 55c6a062-5f4a-4a8b-a8e5-05ea5e6715a3 | 25        |
   | be49171b-9f72-4fc9-bf7a-9a52e259836b | 64        |
   | 689fb64e-a4a2-45c5-b9f2-480c2155624d | 56        |
   | b66a7143-c18a-43bb-b5dc-06bb5d1d3160 | 89        |
