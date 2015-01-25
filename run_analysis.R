## run_analysis.R script
## This script takes the input data from
##      https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip
##      Preamble:
##          Get data from the above URL
##          unzip the file to get the test and training data
##          the data of interest is under the train and test directories
##          along with the description data in features.txt, README.txt, activity_labels.txt
##
##      reads the corresponding data into x_train, x_test, y_train, y_test, features, 
##          sub_train and sub_test
##      creates two data sets for training and test data
##      appends columns subject from sub_* and activity from y_* data
##      rbinds the data sets data_train and data_test into data
##  
##      Creates a set of columns with "mean, Mean or std" in the column names
##          as well as the appended columnns subject and activity
##          To keep the order of the columns it uses grep to get indices
##          Please note that to preserve the subject and activity columns it
##              adds two extraneous column names for the indices which are not
##              used for any other purpose
##      picks up the data for only those that match the attributes of interest 
##          -- indices calculated in previous step
##      Then applies ddply to calculate the means columnwise for 
##          each variable for each activity and each subject.
##      writes this to tidy_data.txt file.
require(plyr)

## Load 
x_train <- read.table("UCI HAR Dataset//train//X_train.txt")
x_test <- read.table("UCI HAR Dataset//test//X_test.txt")
y_train <- read.table("UCI HAR Dataset//train//y_train.txt")
y_test <- read.table("UCI HAR Dataset//test//y_test.txt")
sub_train <- read.table("UCI HAR Dataset//train//subject_train.txt")
sub_test <- read.table("UCI HAR Dataset//test//subject_test.txt")
features <- read.table("UCI HAR Dataset//features.txt")

data_train <- cbind(y_train, x_train)
data_train <- cbind(sub_train, data_train)
data_test <- cbind(y_test, x_test)
data_test <- cbind(sub_test, data_test)
data <- rbind(data_train, data_test)

x_colnames <- as.character(features[,2])
## add two additional "mean" named columns so that indexes are right on grep
x_colnames <- c("mean1", "mean2", x_colnames)
x_mean_attr <- c(grep("mean", x_colnames))
x_Mean_attr <- c(grep("Mean", x_colnames))
x_std_attr <- c(grep("std", x_colnames))
x_attr <- c(x_mean_attr, x_Mean_attr, x_std_attr)
x_attr <- sort(x_attr)

data <- data[, x_attr]

d1<- ddply(data, .(subject,activity), numcolwise(mean))
write.table(d1, "tidy_data.txt", sep=" ")
