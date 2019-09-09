---
title: "Practice"
author: "Nirvesh"
date: "7/22/2019"
output: html_document
---

```{r setup, include=FALSE}
knitr::opts_chunk$set(echo = TRUE)
knitr::opts_knit$set(root.dir = "/Users/Nirvesh/Documents")
```

## R Markdown

This is an R Markdown document. Markdown is a simple formatting syntax for authoring HTML, PDF, and MS Word documents. For more details on using R Markdown see <http://rmarkdown.rstudio.com>.

When you click the **Knit** button a document will be generated that includes both content as well as the output of any embedded R code chunks within the document. You can embed an R code chunk like this:

```{r cars}
summary(cars)
```

## Including Plots

You can also embed plots, for example:

```{r pressure, echo=FALSE}
plot(pressure)
```

Note that the `echo = FALSE` parameter was added to the code chunk to prevent printing of the R code that generated the plot.

```{r}
setwd("/Users/Nirvesh/Documents")

```

```{r}
require(caret)

```


```{r}
practice <- read.csv("iris.csv", header = FALSE)
names(practice) <- c("sepal_length", "sepal_width"," petal_length", "petal_width", "class")
summary(practice)
```

```{r}
practice[practice == "?"] <- NA
practice[practice == "--"] <- NA
practice[practice == "%"] <- NA
practicedata <- na.omit(practice)
summary(practicedata)
```



```{r}
head(practicedata, 3) # view first 3 rows of a dataset
```

```{r}
#list types for each dataset
sapply(practicedata, class)
```

```{r}
levels(practicedata$class)
```

```{r}
percentage <- prop.table(table(practicedata$class))*100
percentage
```

```{r}
summary(practicedata)
```



#After the basic understanding of the data, we need to clean the data and then move forward with visualizing the data to better understand the data. 


#univariate plot - individual variable
```{r}
par(mfrow=c(1,4))
  for(i in 1:4) {
  boxplot(practicedata[,1:4][,i], main=names(practicedata)[i])
  }
```



```{r}
bardata <- table(practicedata$class)
barplot(bardata, col = c('orange', 'purple', 'green'), 
            main = "Iris flower data",
            xlab = "Type of flowers",
            ylab = "Frequency",
            ylim = c(0,70))
```


##scatterplot matrix
```{r}
featurePlot(x=practicedata[,1:4], y=practicedata[,5], plot="ellipse")
```


##figure out the individual features of the class
## Petal length of each class
## Sepal length of each class
#### Petal width of each class
##Sepal width of each class
```{r}
featurePlot(x = practicedata[,1:4], y = practicedata[,5], plot = "box")
```
#Do some more visualization if you like

#Train-Test split
```{r}
train_size <- floor(0.8* nrow(practicedata))
#train_size
train_data<- sample(seq_len(nrow(practicedata)), size = train_size)
#train_data
training = practicedata[train_data, ]
testing= practicedata[-train_data,]
```

#10 fold cross validation
```{r}
fitcontrol <- trainControl(method = "repeatedcv", number = 10, repeats = 1)
system.file(
  rfFit1 <- train(class~., data= training, method = "rf", trControl =fitcontrol)
)
rfFit1
```

