**WEEK 02 HOMEWORK QUESTIONS**

**(Part 1) Models**

1. What is our user repeat rate?
    - *Repeat Rate = Users who purchased 2 or more times / users who purchased*

2. What are good indicators of a user who will likely purchase again? What about indicators of users who are likely NOT to purchase again? If you had more data, what features would you want to look into to answer this question?
    - *NOTE: This is a hypothetical question vs. something we can analyze in our Greenery data set. Think about what exploratory analysis you would do to approach this question.*

3. Explain the marts models you added. Why did you organize the models in the way you did?
    - *Paste in an image of your DAG from the docs. These commands will help you see the full DAG
        - $ dbt docs generate 
        - $ dbt docs serve --no-browser   

**(Part 2) Tests**

1. What assumptions are you making about each model? (i.e. why are you adding each test?)

2. Did you find any “bad” data as you added and ran tests on your models? How did you go about either cleaning the data in the dbt model or adjusting your assumptions/tests?

3. Apply these changes to your github repo

4. Your stakeholders at Greenery want to understand the state of the data each day. Explain how you would ensure these tests are passing regularly and how you would alert stakeholders about bad data getting through.