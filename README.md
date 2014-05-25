# Course Project Read Me

This is the ReadMe file for the course project written for the _Getting and Cleaning Data_ Coursera course.

## Purpose

The project course takes a database containing sensor data from Samsung smart phones (collected by a University of California Urvine research project entitled _Human Activity Recognition Using SmartPhones_) and then performs the following activities to produce a tidy dataset that can be used for later analysis:

1. Merges the training and the test sets to create one data set.
2. Extracts only the measurements on the mean and standard deviation for each measurement. 
3. Uses descriptive activity names to name the activities in the data set
4. Appropriately labels the data set with descriptive activity names. 
5. Creates a second, independent tidy data set with the average of each variable for each activity and each subject. 

## Sequence of Actions Performed by the Code
To transform the dataset into the specified tidy dataset, the code performs the following specific actions, each of which is triggered by a dedicated function held within the *run_Analysis.R* code file:

* Step 1: Loads from file and then merges the training and the test sets to create one data set.
* Step 2: Identifies only the measurements on the mean and standard deviation measurements. 
* Step 3: Extracts only the measurements identified in Step 2.
* Step 4: Adds descriptive activity names to name the activities in the data set.
* Step 5: Creates a second, independent tidy data set with the average of each variable -- for each activity and each subject.
* Step 6: Makes the column names more descriptive in line with best practice naming conventions.
* Step 7: Writes the Tidy dataset to file.

## Files

This project contains the following files:

1. README.md - The file you are reading now, containing an overview of the code and datafiles.
2. run_analysis.R - This is the file containing the code that translates the Samsung dataset into the tidy dataset specified by the project course assignment.
3. tidyData.csv - This is the **tidy** dataset that is produced by the run_analysis.R code.
4. tidyData.txt - This is the same as the _tidyData.csv_ file, but in txt format so that it could be uploaded to Coursera,
5. CodeBook.md - This is a second document that provides an overview of the variables contained within the tidy dataset that is produced by the run_analysis.R code.


## Assumptions / Requirements

For the code to function properly, it requires that the user have the _Human Activity Recognition Using Smartphones Data Set_ in the R working directory. This dataset can be obtained here: https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip

## How to Use the Code (run_Analysis.R)
To use this code, run the **runAnalysis** function, which will perform all the required functions needed to produce the tidy dataset. Note that this function both saves the resulting dataset into a comma-seperated file named _tidyData.txt_ and returns the tidy dataset as a dataframe. The following is the recommended way of running the code once the **run_Analysis.R** file has been sourced in R:

`tidyData <- runAnalysis()`


## Description of Code Functions (run_Analysis.R)

The run_Analysis code contains the following functions:

0. **runAnalysis**: This is the lead function that performs all required tasks in the appropriate sequence. Assign this to a dataframe variable (i.e. "tidyData <- runAnalysis()").
  * _Arguments:_ None - No arguments are used in this function
  * _Returns:_ dataframe

1. **readDataFiles**: This function reads in and then merges the training and the test sets to create one data set.
  * _Arguments:_ None - No parameters are used in this function
  * _Returns:_ dataframe

2. **loadColumnLabels**: Identifies and renames columns containing measurements with a mean or standard deviation. All other columns are labeled for deletion and then deleted.
  * _Arguments:_ requires dataframe
  * _Returns:_ dataframe

3. **removeUnusedColumns**: This function deletes those columns that were previously identified as not containing a mean or standard deviation measurement
  * _Arguments:_ requires dataframe
  * _Returns:_ dataframe

4. **factorActivityColumn**: This function cleans up the activity column by converting id's into more user-friendly factors (using labels from the "activity-labels.txt file)
  * _Arguments:_ requires dataframe
  * _Returns:_ dataframe

5. **averageData**: This function reshapes the data into a tidy dataframe that contains only the aggregate means for each measurement
  * _Arguments:_ requires dataframe
  * _Returns:_ tidy dataframe

6. **cleanColumnLabels**: This function cleans up the column labels by replacing shortened words with full terms (ex: Mag --> Magnitude)
  * _Arguments:_ requires dataframe
  * _Returns:_ dataframe

7. **writeToFile**: This function prints the tidy dataframe to a CSV file (using .txt format for easy uploading)
  * _Arguments:_ requires tidy dataframe
  * _Returns:_ nothing


The code does not create/use any global variables. Internally, the dataframe variable names _combinedData_ represents the main dataframe which is ultimately converted into the tidy dataset in the dataframe variable named _tidyData_.

