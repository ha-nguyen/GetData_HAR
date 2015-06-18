---
title: "ReadMe"
author: "Ha Nguyen"
date: "June 17, 2015"
output: html_document
---

The purpose of the project is collecting, and transforming dataset collected from: 
http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones

The data set is about measurements of human activities (6 activities - ALKING, WALKING_UPSTAIRS, WALKING_DOWNSTAIRS, SITTING, STANDING, LAYING) using wearable device - smartphones with embedded accelerometer and gyroscope.Each activity is measured in 561 features and is labeled manually by researcher. 

The obtained dataset has been randomly partitioned into two sets, where 70% of the volunteers was selected for generating the training data and 30% the test data. 

The script "run_analysis.R" will do:

* Merges the training and the test sets to create one data set.
* Extracts only the measurements on the mean and standard deviation for each measurement. 
* Uses descriptive activity names to name the activities in the data set
* Appropriately labels the data set with descriptive variable names. 
* From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.

Please read the file CodeBook.md to undertand the data, variables and transformation process 
