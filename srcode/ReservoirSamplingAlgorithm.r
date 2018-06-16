## sort the normal random variable this help to see clearly that stream
## sampling does not care which observations come first
## data <- sort(rnorm(N))
RSA <- function(k)
{
  require(data.table)

  res <- numeric(0)
  for (i in 1:K) {
    res <- c(res, data[i])
  }

  for (i in (K + 1):N) {
    rn <- sample.int(i, 1)
    if (rn <= K)
    {
      res[rn] <- data[i]
    }
  }
  res <- unlist(res)
  return(data.table(res))
}

library(dapre)
library(data.table)

K <- 1000
N <- 10000
data <- data.table(seq(1,10000))

res1 <- RSA(k)
res2 <- RSA(k)
res3 <- RSA(k)
res4 <- RSA(k)
res5 <- RSA(k)
res6 <- RSA(k)
res7 <- RSA(k)
res8 <- RSA(k)
res9 <- RSA(k)
res10 <- RSA(k)

sample.df <- data.frame(res1=res1,
                        res2=res2,
                        res3=res3,
                        res4=res4,
                        res5=res5,
                        res6=res6,
                        res7=res7,
                        res8=res8,
                        res9=res9,
                        res10=res10)
summary(sample.df)
plot(density(res1[1]))

## total distribution
summary(data)
