#### Require the dplyr package ####
if("dplyr" %in% rownames(installed.packages()) == FALSE) {install.packages("dplyr")}
library(dplyr)

#### Define the source and destinate files for the program ####
url <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
zipFile <- "dataFile.zip"
outFile <- "meanMeanAndStdBySubjectAndActivity.txt"

#### Download the data #####
download.file(url, zipFile, method="curl", mode="wb")

#### Load the necessary tables into R ####
testData_x <- read.table(unz(zipFile, "UCI HAR Dataset/test/X_test.txt"))
testData_y <- read.table(unz(zipFile, "UCI HAR Dataset/test/y_test.txt"))
trainData_x <- read.table(unz(zipFile, "UCI HAR Dataset/train/X_train.txt"))
trainData_y <- read.table(unz(zipFile, "UCI HAR Dataset/train/y_train.txt"))
activityLabels <- read.table(unz(zipFile, "UCI HAR Dataset/activity_labels.txt"))
testInd <- read.table(unz(zipFile, "UCI HAR Dataset/test/subject_test.txt"))
trainInd <- read.table(unz(zipFile, "UCI HAR Dataset/train/subject_train.txt"))
features <- read.table(unz(zipFile, "UCI HAR Dataset/features.txt"))

#### Merge test and train data into a single data frame ####
fullData_x <- rbind(testData_x, trainData_x)
fullData_y <- rbind(testData_y, trainData_y)
fullData_ind <- rbind(testInd, trainInd)

#### Rename the columns to meaningful, valid R names using the features file ####
colnames(fullData_x) <- gsub("\\.$", "", gsub("\\.\\.", "\\.", make.names(unlist(features$V2))))
colnames(fullData_y) <- c("activity.code")
colnames(fullData_ind) <- c("subject")
colnames(activityLabels) <- c("activity.code", "activity.name")

#### Combine the various data columns into one data frame ####
combinedData <- cbind(fullData_ind, fullData_x, fullData_y)

#### Create a new data frame with only the subject, the columns with "mean" or "std" in their names, and the activity code
subData <- combinedData[,c("subject", colnames(combinedData)[grep("mean|std", names(combinedData))], "activity.code")]

#### Merge the selected columns with the activity labels and remove the unneeded activity.code variable ####
subData <- merge(subData, activityLabels)
subData$activity.code <- NULL

#### Group the data by subject and activity code ####
subData$subject <- as.factor(subData$subject)
subData$activity.code <- as.factor(subData$activity.name)
groupData <- group_by(subData, subject, activity.name)

#### Create a summary table that contains the mean for each of the values ####
tidyData <- summarise_each(groupData, funs(mean))

#### Write the table to the output file ####
write.table(tidyData, file=outFile, row.names=FALSE)