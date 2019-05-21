#In this worksheet, we will create and examine an example on how the effects of different features may mask the correlation between other features and the target variable. Later, we check some classic examples of the Simpson's paradox
library(ggplot2)

set.seed(42)
#################
### EXAMPLE 1 ###
#################
# We will create 3 independent variable for this example
independent_variable1 <- rnorm(500, mean = 50, sd = 100)
independent_variable2 <- rnorm(500, mean = 0, sd = 200)
independent_variable3 <- rnorm(500, mean = -100, sd = 200)

# The dependent variable will be a linear combination of the previous variables, with some normally distributed error
dependent_variable <- independent_variable1*2 + independent_variable2*5 + independent_variable3*-8  + 20 + rnorm(500,0,10)

# Let's assume we only received the first feature for the analysis. Let's fit a linear model, and browse the summary:
summary(lm(dependent_variable ~ independent_variable1))

# As you can see, the model was inconclusive regarding the coefficient. 
# A quick visualization would also leave us undecided about the correlation:
qplot(independent_variable1, dependent_variable) + labs(title="First variable Vs Dependent variable", 
                                                        y="Dependent variable", 
                                                        x="First variable")

# However, this doesn't mean, there is no correlation... we generated this data with a coeff of 2! 
# The problem is, the second and third independent features has greater effect on the dependent variable. 
# Let's build a linear model with the first and second independent variable :
summary(lm(dependent_variable ~ independent_variable1 + independent_variable2))

# According to the summary, the p-value for the second variable is minimal 
# (which means, if the null hypothesis holds (=second variable's coefficient is zero), the statistic calculated from data or any more extreme case, has a low probability)
# A quick look on a visualization is also convincing
qplot(independent_variable2, dependent_variable) + labs(title="Second variable Vs Dependent variable", 
                                                        y="Dependent variable", 
                                                        x="Second variable")

# Let's include the third variable too:
summary(lm(dependent_variable ~ independent_variable1 + independent_variable2 + independent_variable3))

# Please note, that the first variable's estimate is significant, controlling the second and third variables! 


#################
### EXAMPLE 2 ###
#################
#Let's check a similar case as the first one, but with a categorical variable. So our dataset will have a categorical and a continuous feature:
set.seed(42)
x1 <- rnorm(500, mean = 20, sd = 3)
x2 <- rnorm(500, mean = 25, sd = 2)

y1 <- x1*-1.5 + 100 + rnorm(500, mean = 0, sd = 7)
y2 <- x2*-1.5 + 114 + rnorm(500, mean = 0, sd = 7)

c1 <- rep('A',500)
c2 <- rep('B',500)

Simpsons_paradox_example <- data.frame(X=append(x1,x2), Y=append(y1,y2), C=append(c1,c2))

# Please note, that the coefficient for X, should be -1.5 for both categories! Now if we run a linear model, using only X:
summary(lm(Y ~ X, data = Simpsons_paradox_example))

# We get an inconclusive result, yet again. 
qplot(X,Y,data=Simpsons_paradox_example) + labs(title="X Vs Y", 
                                                y="Dependent variable", 
                                                x="Continuous variable")
# If we implement the categorical variable into the linear model, we get the desired result
summary(lm(Y ~ X + C, data = Simpsons_paradox_example))

# When we include variable C in the plot, the correlation gets more visible
qplot(X,Y,data=Simpsons_paradox_example, colour = C) + stat_smooth(method = "lm", se = FALSE) + labs(title="X Vs Y", 
                                                y="Dependent variable", 
                                                x="Continuous variable")

#################
### EXAMPLE 3 ###
#################
#We can generate a dataset that will actually show us a significant positive correlation for X and Y. But this will change when we controll variable C
set.seed(42)
x1 <- rnorm(500, mean = 20, sd = 3)
x2 <- rnorm(500, mean = 50, sd = 2)

y1 <- x1*-1.5 + 100 + rnorm(500, mean = 0, sd = 7)
y2 <- x2*-1.5 + 200 + rnorm(500, mean = 0, sd = 7)

c1 <- rep('A',500)
c2 <- rep('B',500)

Simpsons_paradox_example <- data.frame(X=append(x1,x2), Y=append(y1,y2), C=append(c1,c2))

# Please note again, that the coefficient for X, should be -1.5 for both categories! Now if we run a linear model, using only X:
summary(lm(Y ~ X, data = Simpsons_paradox_example))

# The summary suggest a positive correlation, a quick visualization shows us why:
qplot(X,Y,data=Simpsons_paradox_example) + stat_smooth(method = "lm", se = FALSE) + labs(title="X Vs Y", 
                                                y="Dependent variable", 
                                                x="Continuous variable")

# So controlling for C, X will shows decrease in Y
summary(lm(Y ~ X + C, data = Simpsons_paradox_example))
qplot(X,Y,data=Simpsons_paradox_example, colour = C) + stat_smooth(method = "lm", se = FALSE) + labs(title="X Vs Y", 
                                                                                                     y="Dependent variable", 
                                                                                                     x="Continuous variable")
