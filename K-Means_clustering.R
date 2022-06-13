# K Means Clustering
df = read.csv('Mall_Customers.csv')
View(df)
x = df[4:5]

# using the elbow method to find the optimal number of cluster
set.seed(6)
wcss = vector()
for (i in 1:10)wcss[i] = sum(kmeans(x, i)$withinss)
plot(1:10, wcss, type='b', main = paste('Cluster of clients'), xlab='Number of clusters', ylab='WCSS')

# applying k-means to the dataset
set.seed(29)
kmeans = kmeans(x,5, iter.max = 300, nstart = 10)

# visualizing the cluster
library(cluster)
clusplot(x,
         kmeans$cluster,
         lines = 0,
         shade = TRUE,
         color = TRUE,
         labels = 2,
         plotchar = FALSE,
         span = TRUE,
         main = paste('Clusters of clients'),
         xlab = 'Annual Income',
         ylab = 'Spending Score'
         )