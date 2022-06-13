df = read.csv('Salary_Data.csv')
View(df)

# splitting the data set
library(caTools)
set.seed(123)
split = sample.split(df$Salary, SplitRatio = 0.75)
training_set = subset(df, split == TRUE)
test_set = subset(df, split == FALSE)

# applying regressor formula
regressor = lm(formula = Salary ~ YearsExperience, data = training_set)
summary(regressor)

# predicting test set results
y_pred = predict(regressor, newdata = test_set)
y_pred

# visualization
library('ggplot2')
ggplot() +
  geom_point(aes(x = training_set$YearsExperience, y = training_set$Salary),
             colour= 'blue') +
  geom_line(aes(x= training_set$YearsExperience, y = predict(regressor, newdata = training_set)),
            colour = 'green') +
  ggtitle('Salary Vs Experience (Training Set)') +
  xlab('Years of Experience') +
  ylab('Salary')

ggplot() +
  geom_point(aes(x = test_set$YearsExperience, y = test_set$Salary),
             colour= 'red') +
  geom_line(aes(x= training_set$YearsExperience, y = predict(regressor, newdata = training_set)),
            colour = 'black') +
  ggtitle('Salary Vs Experience  (Test Set)') +
  xlab('Years of Experience') +
  ylab('Salary')