# Simpson's paradox

We will create and examine an example on how the effects of different features may mask the correlation between other features and the target variable. Later, we check some classic examples of the Simpson's paradox.

## The first example
In the first example 3 independent variables are created. The dependent variable will be a linear combination of the previous variables, with some normally distributed error.

Let's assume we only received the first feature for the analysis. Let's fit a linear model, and browse the summary:

                      Estimate       Std. Error t value Pr(>|t|)   
                      
    (Intercept)           899.3649    92.4218   9.731   <2e-16 ***

    independent_variable1   1.2699     0.8566   1.482    0.139   

As you can see, the model was inconclusive regarding the coefficient. A quick visualization would also leave us undecided about the correlation:

![Alt text](1.png?raw=true "")

However, this doesn't mean, there is no correlation... we generated this data with a coeff of 2! The problem is, the second and third independent features has greater effect on the dependent variable. Let's build a linear model with the first and second independent variable:

                      Estimate       Std. Error t value Pr(>|t|)    
                      
    (Intercept)           916.7314    76.9787  11.909   <2e-16 ***

    independent_variable1   1.3592     0.7134   1.905   0.0573 .  

    independent_variable2   4.9912     0.3357  14.867   <2e-16 ***

According to the summary, the p-value for the second variable is minimal (which means, if the null hypothesis holds (=second variable's coefficient is zero), the statistic calculated from data or any more extreme case, has a low probability) A quick look on a visualization is also convincing:

![Alt text](2.png?raw=true "")

If we include the third variable too, we get the following summary:

                       Estimate      Std. Error t value Pr(>|t|)    
                       
    (Intercept)           20.092752   0.564395    35.6   <2e-16 ***

    independent_variable1  2.000136   0.004640   431.1   <2e-16 ***

    independent_variable2  4.999140   0.002182  2291.4   <2e-16 ***

    independent_variable3 -8.001897   0.002333 -3430.6   <2e-16 ***

As you can see, controlling the second and third variables, we can now predict positive correlation better than chance.

## The second example
Let's check a similar case as the first one, but with a categorical variable. So our dataset will have a categorical (C) and a continuous feature (X), and a continuous target/dependent variable (Y). Now, let's run a linear model, using only X:

            Estimate       Std. Error t value Pr(>|t|)   
            
    (Intercept) 74.26749    1.72193  43.130   <2e-16 ***

    X           -0.04256    0.07580  -0.561    0.575  

Yet again, we get an inconclusive result.

![Alt text](3.png?raw=true "")

If we implement the categorical variable into the linear model, we get the desired result

            Estimate       Std. Error t value Pr(>|t|)    
            
    (Intercept) 98.87245    1.74913   56.53   <2e-16 ***

    X           -1.45795    0.08647  -16.86   <2e-16 ***

    CB          14.29384    0.61735   23.15   <2e-16 ***
    
![Alt text](4.png?raw=true "")

## The third example
We can generate a dataset that will actually show us a significant positive correlation for X and Y from the second example. But this will change when we control variable C. The coefficient for X, will be -1.5 for both categories in the dataset! Let's see a visuaization of the dataset:

![Alt text](5.png?raw=true "")

Now if we run a linear model, using only X:

            Estimate        Std. Error t value Pr(>|t|)   
            
    (Intercept)  36.2809     0.8498   42.70   <2e-16 ***

    X             1.7543     0.0223   78.68   <2e-16 ***
    
Please note, that the model suggest a small p-value for a positive coefficient! If we consider the categorical variable C, we get the true coefficient, used while generating the dataset.

![Alt text](6.png?raw=true "")

            Estimate       Std. Error t value Pr(>|t|)    
    (Intercept) 98.87245    1.74913   56.53   <2e-16 ***
    X           -1.45795    0.08647  -16.86   <2e-16 ***
    CB          99.24250    2.63468   37.67   <2e-16 ***
