# kernel PCA
df = read.csv('Social_Network_Ads.csv')
View(df)
df =df[,3:5]
View(df)
# splitting the data set
library(caTools)
set.seed(123)
split = sample.split(df$Purchased, SplitRatio = 0.75)
training_set = subset(df, split == TRUE)
test_set = subset(df, split == FALSE)

# Feature Scaling
training_set[,1:2] = scale(training_set[,1:2])
test_set[,1:2] = scale(test_set[,1:2])

# applying kernel PCA
install.packages('kernlab')
library(kernlab)
kpca = kpca(~., data=training_set[-3], kernel='rbfdot', features=2)
training_set_pca = as.data.frame(predict(kpca, training_set))
training_set_pca$Purchaser = training_set$Purchased
test_set_pca = as.data.frame(predict(kpca, test_set))
test_set_pca$Purchaser = test_set$Purchased
# Fitting Logistic regression to  the training set
classifier = glm(formula = Purchased ~ . ,
                 family = binomial,
                 data = training_set_pca)
summary(classifier)

# predicting test set results
prob_pred= predict(classifier,type = 'response', newdata = test_set_pca[-3])
prob_pred

y_pred = ifelse(prob_pred > 0.5, 1, 0)
y_pred

# Making the confusion matrix
cm = table(test_set_pca[,3],y_pred)
cm

# Visualization of training set
install.packages('ElemStateLearn')
library(ElemStatLearn)
set = training_set_pca
X1 = seq(min(set[, 1]) - 1, max(set[, 1]) + 1, by = 0.01)
X2 = seq(min(set[, 2]) - 1, max(set[, 2]) + 1, by = 0.01)
grid_set = expand.grid(X1, X2)
colnames(grid_set) = c('V1', 'V2')
prob_set = predict(classifier, type = 'response', newdata = grid_set)
y_grid = ifelse(prob_set > 0.5, 1, 0)
plot(set[, -3],
     main = 'Logistic Regression (Training set)',
     xlab = 'PC1', ylab = 'PC2',
     xlim = range(X1), ylim = range(X2))
contour(X1, X2, matrix(as.numeric(y_grid), length(X1), length(X2)), add = TRUE)
points(grid_set, pch = '.', col = ifelse(y_grid == 1, 'springgreen3', 'tomato'))
points(set, pch = 21, bg = ifelse(set[, 3] == 1, 'green4', 'red3'))

# visualizing Test dataset
library(ElemStatLearn)
set = test_set_pca
X1 = seq(min(set[, 1]) - 1, max(set[, 1]) + 1, by = 0.01)
X2 = seq(min(set[, 2]) - 1, max(set[, 2]) + 1, by = 0.01)
grid_set = expand.grid(X1, X2)
colnames(grid_set) = c('V1', 'V2')
prob_set = predict(classifier, type = 'response', newdata = grid_set)
y_grid = ifelse(prob_set > 0.5, 1, 0)
plot(set[, -3],
     main = 'Logistic Regression (Testset)',
     xlab = 'PC1', ylab = 'PC2',
     xlim = range(X1), ylim = range(X2))
contour(X1, X2, matrix(as.numeric(y_grid), length(X1), length(X2)), add = TRUE)
points(grid_set, pch = '.', col = ifelse(y_grid == 1, 'springgreen3', 'tomato'))
points(set, pch = 21, bg = ifelse(set[, 3] == 1, 'green4', 'red3'))