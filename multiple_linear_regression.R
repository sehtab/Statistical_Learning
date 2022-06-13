df = read.csv('50_Startups.csv')
View(df)

# Encoding categorical data
df$State = factor(df$State,
                  levels = c('New York', 'California', 'Florida'),
                  labels = c(1, 2, 3))
# splitting the data set
library(caTools)
set.seed(123)
split = sample.split(df$Profit, SplitRatio = 0.75)
training_set = subset(df, split == TRUE)
test_set = subset(df, split == FALSE)

# fitting Multiple linear regression & applying regressor formula
regressor = lm(formula = Profit ~ . , data = training_set)
summary(regressor)

# predicting test set results
y_pred = predict(regressor, newdata = test_set)
y_pred

# Building the optimal model using backward Elimination
regressor = lm(formula = Profit ~ R.D.Spend + Administration + Marketing.Spend + State , data = df)
summary(regressor)

regressor = lm(formula = Profit ~ R.D.Spend + Administration + Marketing.Spend , data = df)
summary(regressor)

regressor = lm(formula = Profit ~ R.D.Spend  + Marketing.Spend + State , data = df)
summary(regressor)

regressor = lm(formula = Profit ~ R.D.Spend , data = df)
summary(regressor)
# visualization
library('ggplot2')
ggplot() +
  geom_point(aes(x = training_set$R.D.Spend, y = training_set$Profit),
             colour= 'blue') +
  geom_line(aes(x= training_set$R.D.Spend, y = predict(regressor, newdata = training_set)),
            colour = 'green') +
  ggtitle('Profit  Vs R.D.Spend (Training Set)') +
  xlab('R.D.Spend') +
  ylab('Profit')

ggplot() +
  geom_point(aes(x = test_set$R.D.Spend, y = test_set$Profit),
             colour= 'red') +
  geom_line(aes(x= training_set$R.D.Spend, y = predict(regressor, newdata = training_set)),
            colour = 'black') +
  ggtitle('Profit  Vs R.D.Spend  (Test Set)') +
  xlab('R.D.Spend') +
  ylab('Profit')