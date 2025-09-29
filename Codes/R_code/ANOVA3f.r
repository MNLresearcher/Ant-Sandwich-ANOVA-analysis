# Reading the 'sandwich.csv' file into a dataframe

library(ggplot2)
library(dae)

dataset = read.csv('C:\example\path\sandwich.csv', header = TRUE)

# Modeling the three-factor ANOVA with repeated measures

model <- aov(antCount ~ topping*bread*butter, data = dataset)
# Checking the normality with a histogram

jpeg(file="C:\example\path\Histogram.jpg")

x = dataset$antCount

hist(x)

dev.off()

# Checking the normality with a Q-Q plot

jpeg(file="C:\example\path\qqplot.jpg")

qqnorm(model$residuals)

# Adding a line for comparison

qqline(model$residuals)

dev.off()

# Checking the equal variance hypothesis with boxplots for all factors

jpeg(file="C:\example\path\Boxplot_topping.jpg")

boxplot(antCount ~ topping, xlab='Topping', ylab='Ant Count', data=dataset)

dev.off()

jpeg(file="C:\example\path\Boxplot_bread.jpg")

boxplot(antCount ~ bread, xlab='Bread', ylab='Ant Count', data=dataset)

dev.off()

jpeg(file="C:\example\path\Boxplot_butter.jpg")

boxplot(antCount ~ butter, xlab='Butter', ylab='Ant Count', data=dataset)

dev.off()

# Gathering summary of data

print(tapply(dataset$antCount, dataset$bread, sd))
print(tapply(dataset$antCount, dataset$butter, sd))
print(tapply(dataset$antCount, dataset$topping, sd))

# Creating interaction plots

interaction.ABC.plot(response = antCount,
					x.factor = topping,
					groups.factor = bread,
					trace.factor = butter,
					data = dataset,
					title = "Interaction Plot",
					xlab = "Topping",
					ylab = "Number of ants",
					ggplotFuncs = NULL)

# Display of the results

print(summary(model))

# Conducting Tukey's range test with a significance value of 5%

Test <- TukeyHSD(model, conf.level=.95)

#print(Test)