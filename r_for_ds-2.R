install.packages('tidyr')
library('tidyr')

n = 10

wide = data.frame(
  ID = c(1:n),
  Face.1 = c(411,412,413,414,415,416,417,418,419,420),
  Face.2 = c(421,422,423,424,425,426,427,428,429,430),
  Face.3 = c(431,432,433,434,435,436,437,438,439,440)
)

View(wide)

# gather() -reshaping data from wide format to long format

long = wide %>% gather(Face, responseTime, Face.1:Face.3)
View(long)

# separate() - splits a single column into multiple columns
long_separate = long %>% separate(Face, c('Target', 'Number'))
View(long_separate)

# unite() combines multiple columns into a single column
long_unite = long_separate %>% unite(Face, Target, Number, sep = ".")
View(long_unite)

# spread() - take two columns (key & value) and spreads into multiple columns
back_to_wide = long_unite %>% spread(Face, responseTime)
View(back_to_wide)

