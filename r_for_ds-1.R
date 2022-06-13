install.packages("dplyr")
library(dplyr)
install.packages("nycflights13")
library(nycflights13)

View(flights)
head(flights)

# subset data set using filter

f1 = filter(flights,month==07)
View(f1)
head(f1)

f2 = filter(flights,month==07,day==3)
View(f2)
View(filter(flights,month==09,day==2,origin=='LGA'))
#or
head(flights[flights$month==09 & flights$day==2 & flights$origin=='LGA',])

# slice() allows to select rows by position
slice(flights,1:5)
slice(flights,5:10)

# mutate() is used to add new column
over_delay = mutate(flights, overall_delay=arr_delay-dep_delay)
View(over_delay)
View(flights)
head(over_delay)

# transmute() function is used to show only new column
over_delay = transmute(flights,overall_delay=arr_delay-dep_delay)
View(over_delay)

# summarise() used to find descriptive statistics
summarise(flights, avg_air_time=mean(air_time,na.rm=T))
summarise(flights,tot_air_time=sum(air_time,na.rm=T))
summarise(flights,tot_air_time=sd(air_time,na.rm=T))
summarise(flights,tot_air_time=mean(air_time,na.rm=T),tot_air_time=sum(air_time,na.rm = T))

# group by calculation using group_by()

# Example 1:
head(mtcars)

by_gear = mtcars %>% group_by(gear)
View(by_gear)
a = summarise(by_gear, gear1=sum(gear), gear2=mean(gear))
a

summarise(group_by(mtcars,cyl), mean(gear, na.rm=T))

b = by_gear %>% summarise(gear1=sum(gear), gear2=mean(gear))
b

# example 2:
by_cyl = mtcars %>% group_by(cyl)

by_cyl %>% summarise(gear=mean(gear),hp=mean(hp))

# sample_n() and sample_frac for creating samples
sample_n(flights,15) # gives 15 random samples

sample_frac(flights,0.4) # returns 40% of the total data

# arrange() used to sort dataset
View(arrange(flights,year,dep_time))

# usage of pipe operator %>%

df = mtcars
df
View(mtcars)

# Nesting
result = arrange(sample_n(filter(df,mpg>20),size=5), desc(mpg))
result

# multiple assignment

a = filter(df,mpg>20)
b = sample_n(a,size=5)
result = arrange(b,desc(mpg))
result

# same using pipe operator
# syntax- data %>% op1 %>% op2 %>% op3
result = df %>% filter(mpg>20) %>% sample_n(size=10) %>% arrange(desc(mpg))
result

# select data
df
df_mpg_hp_cyl = df %>% select(mpg,hp,cyl)
df_mpg_hp_cyl

