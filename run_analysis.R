# Author - Ha Nguyen 
# Course Project - Getting and Transforming data set of Human Activity Recognition 
# Reference: http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones

# Getting data, unzip 
download.file(url = "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip", destfile = "HARDataset.zip")
  

unzip(zipfile = "HARDataset.zip", exdir = "HARDataset")

setwd(dir = "HARDataset/UCI HAR Dataset/")

# Read training data 
x_train <- read.table(file = "train/X_train.txt", stringsAsFactors = F, colClasses = "numeric", comment.char = "")
y_train <- read.table(file = "train/y_train.txt", stringsAsFactors = F, colClasses = "numeric", comment.char = "", col.names = "id")

# Read test data 
x_test <- read.table("test/X_test.txt", stringsAsFactors = F, colClasses = "numeric", comment.char = "")
y_test <- read.table("test/y_test.txt", stringsAsFactors = F, colClasses = "numeric", comment.char = "", col.names = "id")

# Merge training and test 
X <- rbind(x_train, x_test)
y <- rbind(y_train, y_test)

# Read features name 
features <- read.table(file = "features.txt", sep = " ", header = F, stringsAsFactors = F, col.names = c("id","name"))

# Get variables measuring mean 
features_mean_name <-features[grep("mean()",features$name, fixed = T),]

# Find variables measuring standard deviation 
features_std_name <- features[grep("std()", features$name, fixed = T),]

# merge them  and sort by their position 
features_mean_std <- rbind(features_mean_name, features_std_name)
features_mean_std <- features_mean_std[order(features_mean_std$id),]

# extract only mean and standard deviation measurement from the data 
X_mean_std <- subset(X, select = features_mean_std$id)

# Label variables with descriptive names specified in "features_mean_std" df
names(X_mean_std) <- features_mean_std$name

# Edit variable names
## Upper intial character in "mean", "std"
## Remove "(), - "
names(X_mean_std) <- gsub("mean()", "Mean", names(X_mean_std), fixed = T)
names(X_mean_std) <- gsub("std()", "Std", names(X_mean_std), fixed = T)
names(X_mean_std) <- gsub("-", "", names(X_mean_std), fixed = T)

# Read activity labels 
activity <- read.table(file = "activity_labels.txt", col.names = c("id", "ActivityName"))

# Decode the Activity ID in the data set (using join function of plyr package to preserve row order)
library(plyr)
y_labeled <- join(y, activity)

# Read subject (people who take experiments)
subject_train = read.table(file = "train/subject_train.txt", col.names = "SubjectId")
subject_test = read.table(file = "test/subject_test.txt", col.names = "SubjectId")
subject = rbind(subject_train, subject_test)

# Combine subject, X and y df to get complete data set 
HAR <- cbind(subject, X_mean_std, ActivityName = y_labeled$ActivityName)

# Create a tidy dataset calculating average of each variable for each activity and each subject 
HAR_bySubject_Activity <- aggregate(HAR[,2:67], by = HAR[c("ActivityName", "SubjectId")], FUN=mean)

# Change the order of table column (first column: "SubjectId", last column: "ActivityName")
HAR_bySubject_Activity <- select(.data = HAR_bySubject_Activity, 2, 3:68, 1 )

# Write to a file 
write.table(HAR_bySubject_Activity, file = "tidyHAR.txt", row.name=FALSE)

#Testing by trying to read again 
data <- read.table("tidyHAR.txt", header = TRUE)
View(data)

