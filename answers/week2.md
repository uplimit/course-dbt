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
