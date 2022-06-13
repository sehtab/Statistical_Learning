install.packages('datasets')
plot(ChickWeight)

# base graphics
library(MASS)
plot(UScereal$sugars, UScereal$calories)
title("plot(UScereal$sugars, UScereal$calories)")

x = UScereal$sugars
y = UScereal$calories
library(grid)

# grid graphics
push.viewport(plotViewport())
push.viewport(dataViewport(x,y))
grid.rect()
grid.xaxis()
grid.yaxis()
grid.points(x,y)
grid.text("UScereal$calories", x = unit(-3, 'lines'), rot = 90)
grid.text("UScereal$calories", y= unit(-3, "lines"), rot=0)
popViewport(2)

# pie chart for different products

x = c(33, 45, 70, 110)
labels = c('soap','detergent','oil','shampoo')

#plot the chart
pie(x,labels)
pie(x, labels, main = 'City pie chart', col= rainbow(length(x)))
piepercent = round(100*x/sum(x), 1)
pie(x, labels=piepercent, main = 'City pie chart', col= rainbow(length(x)))
legend('topright', c('Soap','Shampoo','Oil','Grocery'), cex=0.8, fill=rainbow(length(x)))

# 3D piechart
install.packages('plotrix')
library(plotrix)
x = c(33, 45, 70, 110)
labels = c('soap','detergent','oil','shampoo')
pie3D(x, labels=labels,explode=0.1, main='Pie chart of countries')

# create the histogram
v = c(9,13,21,8,36,22,12,41,31,33,19)
hist(v, xlab='Weight', col='green',border='red')
hist(v, xlab='weight',col='green', border='red',xlim=c(0,40),ylim=c(0,5), breaks=5)

data('airquality')
View(airquality)

plot(airquality$Ozone, airquality$Wind)
plot(airquality)

hist(airquality$Solar.R)

temp= airquality$Temp
hist(temp)

# histogram with labels
h = hist(temp, ylim=c(0,40))
text(h$mids, h$counts, labels=h$counts, adj=c(0.5, -0.5))

# boxplot
boxplot(airquality$Solar.R)

# multiple boxplot
boxplot(airquality[,0:4], main='Multiple Box Plots')

# using ggplot2 library to analyse mtcars dataset
install.packages('ggplot2')
library(ggplot2)
attach(mtcars)

p1 = ggplot(mtcars, aes(factor(cyl), mpg))
p1 + geom_boxplot()
p1+geom_boxplot()+coord_flip()
p1+geom_boxplot(aes(fill=factor(cyl)))

# scatter plot
ggplot(data=mtcars, mapping=aes(x=wt,y=mpg)) + geom_point()

ggplot2::mpg
# bar plot
ggplot(data=ggplot2::mpg, aes(class)) + geom_bar()

# stacked bar chart
ggplot(data=ggplot2::mpg, aes(class)) + geom_bar(aes(fill=drv))

# using dodge
ggplot(data=ggplot2::mpg, aes(class)) + geom_bar(aes(fill=drv),position='dodge')

# using plotly
install.packages('plotly')
library(plotly)
p = plot_ly(data=mtcars, x = ~hp, y=~wt, color=~hp, size=~hp)
p