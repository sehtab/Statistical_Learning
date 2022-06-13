# Decision tree classifier
df = read.csv('Social_Network_Ads.csv')
View(df)
df =df[,3:5]
View(df)

# Encoding the target feature as factor
df$Purchased = factor(df$Purchased, levels = c(0, 1))
# splitting the data set
library(caTools)
set.seed(123)
split = sample.split(df$Purchased, SplitRatio = 0.75)
training_set = subset(df, split == TRUE)
test_set = subset(df, split == FALSE)

# Feature Scaling
training_set[,1:2] = scale(training_set[,1:2])
test_set[,1:2] = scale(test_set[,1:2])

# Fitting Naive-Bayes regression to  the training set
#install.packages('class')
library(rpart)
classifier = rpart(formula = Purchased ~ .,
                   data = training_set)
summary(classifier)

# predicting the test set result
y_pred = predict(classifier, newdata = test_set[-3], type = 'class')
y_pred

# Making the confusion matrix
cm = table(test_set[,3],y_pred)
cm

# Visualization of training set
#install.packages('ElemStateLearn')
library(ElemStatLearn)
set = training_set
X1 = seq(min(set[, 1]) - 1, max(set[, 1]) + 1, by = 0.01)
X2 = seq(min(set[, 2]) - 1, max(set[, 2]) + 1, by = 0.01)
grid_set = expand.grid(X1, X2)
colnames(grid_set) = c('Age', 'EstimatedSalary')
y_grid = predict(classifier, newdata = grid_set, type = 'class')
plot(set[, -3],
     main = 'Decision Tree  (Training set)',
     xlab = 'Age', ylab = 'Estimated Salary',
     xlim = range(X1), ylim = range(X2))
contour(X1, X2, matrix(as.numeric(y_grid), length(X1), length(X2)), add = TRUE)
points(grid_set, pch = '.', col = ifelse(y_grid == 1, 'springgreen3', 'tomato'))
points(set, pch = 21, bg = ifelse(set[, 3] == 1, 'green4', 'red3'))

# Visualization of training set
#install.packages('ElemStateLearn')
library(ElemStatLearn)
set = test_set
X1 = seq(min(set[, 1]) - 1, max(set[, 1]) + 1, by = 0.01)
X2 = seq(min(set[, 2]) - 1, max(set[, 2]) + 1, by = 0.01)
grid_set = expand.grid(X1, X2)
colnames(grid_set) = c('Age', 'EstimatedSalary')
y_grid =  predict(classifier, newdata = grid_set, type = 'class')
plot(set[, -3],
     main = 'Decision Tree (Test set)',
     xlab = 'Age', ylab = 'Estimated Salary',
     xlim = range(X1), ylim = range(X2))
contour(X1, X2, matrix(as.numeric(y_grid), length(X1), length(X2)), add = TRUE)
points(grid_set, pch = '.', col = ifelse(y_grid == 1, 'springgreen3', 'tomato'))
points(set, pch = 21, bg = ifelse(set[, 3] == 1, 'green4', 'red3'))

# plotting the decision tree
plot(classifier)
text(classifier)
