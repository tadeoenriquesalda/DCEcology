library(tidyverse)

download.file("https://ndownloader.figshare.com/files/2292169", 
              "data/portal_data_joined.csv")

surveys<-read.csv("data/portal_data_joined.csv")
surveys
View(surveys)
head(surveys)

dim(surveys) 
# dim - give a count of row and columns
nrow(surveys) 
# nrow - number of rows
ncol(surveys) 
#ncol(surveys) - number of colums
head(surveys) 
#head(surveys) 
tail(surveys) 
names(surveys)
rownames(surveys)
str(surveys)
summary(surveys)

#Chalenge1 - What is factor??
#Based on the output of str(surveys), can you answer the following questions?
#What is the class of the object surveys? data.frame : str(surveys)
#How many rows and how many columns are in this object? 34786 rows and 13 columns
#How many species have been recorded during these surveys?13  - 48 - 40
str(surveys)
sex<- factor(c("male","female","female","male"))
levels(sex)
nlevels(sex)

lvls<-factor(c("high","medium","low"))
levels(lvls)

lvls<-factor(lvls, levels=c("low","medium","high"))
levels(lvls)

as.character(lvls)

year_fct<-factor(c(1990,1983,1977,1998,1990))
as.numeric(year_fct)

year_fct<-factor(c(1990,1983,1977,1998,1990))
as.numeric(as.character(year_fct))
as.numeric(levels(year_fct))[year_fct]


##

plot(surveys$sex)
levels(surveys$sex)

sex<-surveys$sex
levels(sex)

#Challenge 2
#Rename “F” and “M” to “female” and “male” respectively.
#Now that we have renamed the factor level to “undetermined”, can you recreate the barplot such that “undetermined” is last (after “male”)?

sex<-surveys$sex
levels(sex)

levels(sex)[1] <- "undetermined"
levels(sex)
levels(sex)[2] <- "female"
levels(sex)
levels(sex)[3] <- "male"
levels(sex)

levels(sex)[2:3] <- c("female","male")

sex<-factor(sex, levels=c("female","male","undetermined"))
levels(sex)
plot(sex)


##

surveys<-read.csv("data/portal_data_joined.csv",
                  stringsAsFactors = TRUE)
str(surveys)


surveys<-read.csv("data/portal_data_joined.csv",
                  stringsAsFactors = FALSE)
str(surveys)

genus<-surveys$genus
surveys$genus<-factor(surveys$genus)
str(surveys)

##

install.packages("lubridate")
library(lubridate)

my_date<-ymd("2015-01-01")
str(my_date)

my_date<-ymd(paste("2015","1","1", sep="-"))
str(my_date)

paste(surveys$year, surveys$month, surveys$day, sep ="-")
ymd(paste(surveys$year, surveys$month, surveys$day, sep ="-"))

surveys$date <- ymd(paste(surveys$year, surveys$month, surveys$day, sep ="-"))

is_missing_year <-is.na(surveys$year)
is_missing_year
is_missing_month <-is.na(surveys$month)
is_missing_month
is_missing_day <-is.na(surveys$day)
is_missing_day

is_missing_date <-is.na(surveys$date)
is_missing_date
date_columns <- c("year","month","day")
missing_dates <- surveys[is_missing_date, date_columns]
head(missing_dates)

