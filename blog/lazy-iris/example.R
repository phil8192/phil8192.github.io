## ---- include=FALSE------------------------------------------------------
options(digits.secs=3)
library(lazyIris)
knitr::opts_chunk$set(dpi=100, fig.width=10, fig.height=6)

## ------------------------------------------------------------------------
# check for and install devtools.
if(!("devtools" %in% rownames(installed.packages())))
  install.packages("devtools")

# install and load.
if(!("lazyIris" %in% rownames(installed.packages())))
  devtools::install_github("phil8192/lazy-iris")
require(lazyIris)

## ------------------------------------------------------------------------
attach(iris.data)

## ------------------------------------------------------------------------
iris.data <- checkData(loadData())

## ---- results="hide"-----------------------------------------------------
cor(iris.data[, 1:4])

## ---- echo=F, results="markup"-------------------------------------------
knitr::kable(cor(iris.data[, 1:4]))

## ------------------------------------------------------------------------
# plot all the data.
visualise(iris.data, class.name="species", main="iris data", plot.hist=TRUE,
    plot.cor=TRUE)

## ---- results="hide"-----------------------------------------------------
# form the query.
# in this example, the feature values are actually the mean values in the
# dataset, thus the results may be interpreted as the top 10 "most average"
# instances.

query <- list(
    sepal.length=5.84,
    sepal.width=3.05,
    petal.length=3.76,
    petal.width=1.20)

# obtain the nearest-neighbours.
top.10 <- knn(query, iris.data, 10)
print(top.10, row.names=FALSE)

## ---- echo=F, results="markup"-------------------------------------------
query <- list(sepal.length=5.84, sepal.width=3.05,
              petal.length=3.76, petal.width=1.20)
top.10 <- knn(query, iris.data, k=10)
knitr::kable(top.10, row.names=F)

## ------------------------------------------------------------------------
query <- list(sepal.length=5.84, sepal.width=3.05, 
              petal.length=3.76, petal.width=1.20)
top.10 <- knn(query, iris.data, k=10)
prediction <- classifier(top.10$species, top.10$distance)
print(paste("prediction =", prediction$pred,
            "confidence =", prediction$conf))

## ------------------------------------------------------------------------
# form the query and obtain the nearest neighbours.
q <- list(sepal.length=5.84, sepal.width=3.05,
          petal.length=3.76, petal.width=1.20)
top.10 <- knn(query, iris.data, k=10)

# visualise the result.
visualise(iris.data, class.name="species", query=q, neighbours=top.10,
    main="iris data neighbours", plot.hist=TRUE, plot.cor=FALSE)

