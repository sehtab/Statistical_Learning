# vector
x = c(1,3,2,5)
x

y = c(1,4,3)
y
z = c(1,2,3)
length(x)
length(y)
length(z)

x+y
y+z
length(y+z)

# list
ls()
# remove
rm(x,y)
ls()
# remove all
rm(list=ls())
ls()

# matrix
m = matrix(data=c(1,2,3,4), nrow=2, ncol=2)
m

n = matrix(c(1,2,3,4),2,2, byrow=TRUE)
n

# sqrt
sqrt(n)

n^2

# rnorm
r = rnorm(50)
r

y = x+rnorm(50,mean=50,sd=0.1)
cor(x,y)

set.seed(1303)
rnorm(50)
mean(r)
var(r)
sqrt(var(r))
sd(r)

################# graphics###############

x = rnorm(100)
y = rnorm(100)
plot(x,y,xlab='X',ylab='Y',main='Plot of X vs Y',col='blue')
pdf('Figure.pdf')
plot(x,y,xlab='X',ylab='Y',main='Plot of X vs Y',col='cyan')
dev.off()

# seq()
x=seq(1,10)
x
x= seq(-pi,pi,length=100)
x

# contour
y=x
f=outer(x,y,function(x,y)cos(y)/(1+x^2))
contour(x,y,f)
contour(x,y,f,nlevels=45,add=T)
fa=(f-t(f))/2
contour(x,y,fa,nlevels=15)

# image
image(x,y,fa)
persp(x,y,fa)
persp(x,y,fa,theta=30)
persp(x,y,fa,theta=30,phi=20)
persp(x,y,fa,theta=30,phi=70)
persp(x,y,fa,theta=30,phi=40)


#################indexing###############
a= matrix(1:16,4,4)
a
a[2,3]
a[c(1,3),c(2,4)]
a[1:3,2:4]
a[1:2,]
a[,1:2]
a[1,]
a[c(1,3),]
dim(a)

##############loading data ###############
auto = read.table('Auto.data', header = T, na.strings='?')
fix(auto)
dim(auto)
