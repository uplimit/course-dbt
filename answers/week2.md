1. What is our user repeat rate?

   - Repeat Rate = Users who purchased 2 or more times / users who purchased

   Query:

   ```sql
   select count_if(is_repeat_buyer) / count(*)
   from fct_user_orders
   where is_buyer = TRUE
   ```

   Result: 0.798387
