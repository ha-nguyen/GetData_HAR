---
title: "CodeBook"
author: "Ha Nguyen"
date: "June 17, 2015"
---

This codebook describe data and variables in the data set Human Activity Recognition 
Reference: http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones


## DATA FILES 
The dataset has been randomly partitioned into training and test data:

 Name                                   | Meaning                                                               
| ------------------------------------  |---------------------------------------------------------------------
| subject_train.txt, subject_test.txt   | Identifer of subject who take experiment                              
| activity_labels.txt                   | Activity name corresponding with number                                
| X_train.txt, X_test.txt               | Activity measurements on 561 features                                 
| y_train.txt, y_test.txt               | Activity labels corresponding with number in activity_labels.txt       
| features.txt                          | 561 features names, each feature is measured in X_*.txt               

## VARIABLES IN DATA FILES: 

### subject_train.txt, subject_test.txt:
* 1 column, including identifier of subject (encoded by number 1-30)

### activity_labels.txt: 
* 1st column: number encoded with the activity name 
* 2nd column: activity name 

### X_train.txt, X_test.txt: 
* Each record measures one activity of a subject (Walking, sitting, laying..)
* Activities are measured by 561 features, corresponding with 561 columns in the data set 

###  y_train.txt, y_test.txt 
* Activity labels encoded by number (1 -> 6), corresponding with activity name in activity_labels.txt

### features.txt:
* 1st column: specifying the position of the feature variable in the data table X_train, X_test
* 2nd column: Names of features 

## TRANSFORMATION PROCESS:

* Read training and test data X_train, X_test 
        - Combine them into one table: X 
        
* Read features name data set
        - Extract features name related to mean() std() measurement 
        - Find out the postion of these extracted features in the table X 
        
* Filter only columns related to extracted features based on their positions, saved into "X_mean_std" table 
* Labels variables name in table X_mean_std with descriptive names corresponding with features name in features.txt 
        - Edit variable names: remove "(), -",..
        
* Uses descriptive activity names in activity_labels.txt to name the activities in the data set 

* Combine subject, measurement (X_mean_std table), activity_name(y table) into complete data set 

* Use aggregate() function to create a tidy dataset calculating average of each variable for each activity and each subject 

* Tidyfile Output: 


Subject ID | FeatureName1 | FeatureName2 | .. FeatureName67 | ActivityName 
------------- | ------------- | ----------| ---------------| -------------| 
| 1         |     -0.92180  | 0.945454     | -0.5454      | 0.9444 | LAYING      
| 1         |     -0.3380   | 0.954        | -0454        | 0.914  | SITTING     
| 1         |     -0.343180 | 0.92344      | -042354      | 0.154  | STANDING   
| 1         |     -0.9580   | 0.94454      | -043454      | 0.444  | WALKING 


...

