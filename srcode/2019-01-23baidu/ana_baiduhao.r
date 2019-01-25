library(dapre)

data <- fread("./keyword_ratio.csv")
datainfo(data)
data

data <- data.table(ratio = rnorm(100,0.7,0.1) + runif(100, -0.1,0),tag = 1)
ggplot_continuous_hist(data,"ratio")
