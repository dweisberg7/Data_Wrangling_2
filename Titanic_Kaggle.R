library(dplyr)
library(tidyr)
library("tidyverse")

dir <- "~/Desktop/RStudio/Titanic_Kaggle"
file <- "titanic_original.csv"
file.output <- "titanic_clean.csv"



# 0: Load the data in RStudio
titanic.original <- read.csv(file.path(dir, file))
titanic.new <- cbind(titanic.original)

#1: Port of embarkation (replace blank cells with S)
titanic.new$embarked <- sub("^$", "S", titanic.new$embarked)
titanic.new$embarked

#2: Age (264 NA's discovered, replaced with mean value 29.8811; used summary(titanic.new$age))
titanic.new$embarked <- sub("N/A", "29.8811", titanic.new$embarked)
titanic.new$age[is.na(titanic.new$age)] <- 29.8811 #mean value
summary(titanic.new$age) #check work
titanic.new$age #I could have replaced with Median age of 28 instead of mean. Predicting with median is more resistant to outliers

#3: Lifeboat
titanic.new$boat <- sub("^$", "NA", titanic.new$boat) #added dummy variable NA for blank cells
titanic.new$boat

#4: Cabin - most people seem to not have cabin #'s
#create new column has_cabin_number = 1 if they have a cabin number and 0 otherwise
titanic.new$cabin <- sub("^$", "NA", titanic.new$cabin)
titanic.new$has_cabin_number <- ifelse(titanic.new$cabin=='NA', 0, 1)

write.csv(titanic.new, file = paste0(dir,"/", file.output), row.names = F)