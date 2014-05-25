# Course Project Read Me

This is the ReadMe file for the course project written for the _Getting and Cleaning Data_ Coursera course.

## Purpose

The project course takes a database containing sensor data from Samsung smart phones (collected by a University of California Urvine research project entitled _Human Activity Recognition Using SmartPhones_) and then performs the following activities to produce a tidy dataset that can be used for later analysis:

1. Merges the training and the test sets to create one data set.
2. Extracts only the measurements on the mean and standard deviation for each measurement. 
3. Uses descriptive activity names to name the activities in the data set
4. Appropriately labels the data set with descriptive activity names. 
5. Creates a second, independent tidy data set with the average of each variable for each activity and each subject. 

## Files

This project contains the following files:

1. README.md - The file you are reading now, containing an overview of the code and datafiles.
2. run_analysis.R - This is the file containing the code that translates the Samsung dataset into the tidy dataset specified by the project course assignment.
3. tidyData.csv - This is the *tidy* dataset that is produced by the run_analysis.R code.
4. tidyData.txt - This is the same as the _tidyData.csv_ file, but in txt format so that it could be uploaded to Coursera,
5. CodeBook.md - This is a second document that provides an overview of the variables contained within the tidy dataset that is produced by the run_analysis.R code.


## Assumptions / Requirements

For the code to function properly, it requires that the user have the _Human Activity Recognition Using Smartphones Data Set_ in the R working directory. This dataset can be obtained here:
'https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip'





