# Simpsons paradox

We will create and examine an example on how the effects of different features may mask the correlation between other features and the target variable

## The first example
In the first example 3 independent variables are created. The dependent variable will be a linear combination of the previous variables, with some normally distributed error.

Let's assume we only received the first feature for the analysis. Let's fit a linear model, and browse the summary:

Coefficients:
                      Estimate Std. Error t value Pr(>|t|)    
(Intercept)           899.3649    92.4218   9.731   <2e-16 ***
independent_variable1   1.2699     0.8566   1.482    0.139   

As you can see, the model was inconclusive regarding the coefficient. A quick visualization would also leave us undecided about the correlation:

