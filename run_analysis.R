# GETTING AND CLEANING DATA: PROJECT COURSE
# To use this code, run the runAnalysis function

# FUNCTION 0: RUNANALYSIS 
# PURPOSE: This is the lead function that performs all required tasks in the appropriate sequence.
# TO USE: Assign this to a dataframe variable (i.e. "tidyData <- runAnalysis()").
# ARGUMENTS: None - No arguments are used in this function
# RETURNS: dataframe
runAnalysis <- function()
{
  # Step 1: Merges the training and the test sets to create one data set.
  combinedData <- readDataFiles()
  
  # Step 2-3: Extracts only the measurements on the mean and standard deviation for each measurement. 
  combinedData <- loadColumnLabels(combinedData)  
  combinedData <- removeUnusedColumns(combinedData)
  
  # Step 4: Uses descriptive activity names to name the activities in the data set.
  combinedData <- factorActivityColumn(combinedData)
  
  # Step 5: Creates a second, independent tidy data set with the average of each variable for
  #         each activity and each subject. 
  tidyData <- averageData(combinedData)
  
  # Step 6: Make the column names more descriptive in line with best practice naming conventions.
  tidyData <- cleanColumnLabels(tidyData)
  
  # Step 7: Writes the Tidy dataset to file.
  writeToFile(tidyData)
  
  # Retun the tidy dataset
  return(tidyData)
}


# FUNCTION 1: READDATAFILES
# PURPOSE: This function reads in and then merges the training and the test sets to create one data set.
# ARGUMENTS: None - No parameters are used in this function
# RETURNS: dataframe
readDataFiles <- function() {
  
  testData <- cbind(read.table("./test/subject_test.txt"), 
                    read.table("./test/X_test.txt", sep=""), 
                    read.table("./test/y_test.txt"))
  
  names(testData)[1]="subject"
  names(testData)[ncol(testData)]="activity"
  
  testData$testGroup <- TRUE
  
  trainData <- cbind(read.table("./train/subject_train.txt"), 
                     read.table("./train/X_train.txt", sep=""), 
                     read.table("./train/Y_train.txt"))
  
  names(trainData)[1]="subject"
  names(trainData)[ncol(trainData)]="activity"
  
  trainData$testGroup <- FALSE
  
  return(rbind(testData,trainData))
}



# FUNCTION 2: LOADCOLUMNLABELS
# PURPOSE: Identifies and renames columns containing measurements with a mean or standard deviation. 
#          All other columns are labeled for deletion and then deleted.
# ARGUMENTS: requires dataframe
# RETURNS: dataframe
loadColumnLabels <- function(data) {
  labels <- read.table("features.txt")
  labelsCount <-nrow(labels) 
  for(i in (labelsCount:1))
  {
    selectedLabel = labels[i,2]
    
    if (grepl("mean()",selectedLabel, fixed=TRUE)){
      selectedLabel <- sub("-mean()","Mean",selectedLabel,fixed=TRUE)
      selectedLabel <- gsub("-","",selectedLabel)
      names(data)[i+1] <- selectedLabel
    }
    
    else if (grepl("std()",selectedLabel,fixed=TRUE)) {
      selectedLabel <- sub("-std()","StdDev",selectedLabel,fixed=TRUE)
      selectedLabel <- gsub("-","",selectedLabel)
      names(data)[i+1] <- selectedLabel
    }
    else
    {
      names(data)[i+1] <- paste("toDelete",toString(i+1)) 
    }
  }
  return(data)
}

# FUNCTION 3: REMOVEUNUSEDCOLUMNS
# PURPOSE: This function deletes those columns that were previously identified
#         as not containing a mean or standard deviation measurement
# ARGUMENTS: requires dataframe
# RETURNS: dataframe
removeUnusedColumns <- function(data)
{
  for (i in (ncol(data) : 1) ){
    
    if ( grepl("toDelete", names(data)[i], fixed=TRUE) ) {
     
      data[,i] <- NULL
      
    }
  }
  return(data)
}

# FUNCTION 4: FACTORACTIVITYCOLUMN
# PURPOSE: This function cleans up the activity column by converting id's into more
#          user-friendly factors (using labels from the "activity-labels.txt file)
# ARGUMENTS: requires dataframe
# RETURNS: dataframe
factorActivityColumn <- function(data)
{
  activityLabels <- read.table("activity_labels.txt")
  data$activity <- factor(data$activity, labels=activityLabels[,2])
  return(data)
}


# FUNCTION 5: AVERAGEDATA
# PURPOSE: This function reshapes the data into a tidy dataframe that contains only the aggregate means for each measurement
# ARGUMENTS: requires dataframe
# RETURNS: tidy dataframe
averageData <- function(data)
{

  #define the factors by which the table will be reshaped
  avgData.factors <- list(subject = factor(data$subject), activity = data$activity)
  
  # remove these from the dataset itself (non-numeric)  
  data$subject <- NULL
  data$activity <- NULL
  data$testGroup <- NULL
  
  #aggregate the means for each data column by the subject/activity factors
  avgData <- aggregate(x=data, by=avgData.factors, mean)
  
  return(avgData)  
}

# FUNCTION 6: CLEANCOLUMNLABELS
# PURPOSE: This function cleans up the column labels by replacing shortened words with full terms (ex: Mag --> Magnitude)
# ARGUMENTS: requires dataframe
# RETURNS: dataframe
cleanColumnLabels <- function(data){
  
  columnNames <- names(data)
  for (columnIndex in 1:length(columnNames))
  {
    
    columnLabel <- columnNames[columnIndex]
    
    # skip index columns
    if ( !(columnLabel %in% c("subject","activity","testGroup")) ) {
      
      #replace shortened words with full word
      columnLabel <- sub("Acc","Accelerometer",columnLabel,fixed=TRUE)
      columnLabel <- sub("Gyro","Gyroscope",columnLabel,fixed=TRUE)
      columnLabel <- sub("Mag","Magnitude",columnLabel,fixed=TRUE)
      
      # replace the leading t and f's with their full meaning
      if (regexpr("t",columnLabel,fixed=TRUE)[1] == 1) {
        columnLabel <- sub("t","time",columnLabel,fixed=TRUE)
      }
      else if (regexpr("f",columnLabel, fixed=TRUE)[1] == 1) {
        columnLabel <- sub("f","frequency",columnLabel,fixed=TRUE)
      }
      
      names(data)[columnIndex] <- columnLabel
    }
    
  }
  
  return(data)
}

# FUNCTION 7: WRITETOFILE
# PURPOSE: This function prints the tidy dataframe to a CSV file (using .txt format for easy uploading)
# ARGUMENTS: requires tidy dataframe
# RETURNS: nothing
writeToFile <- function(data) {
  write.csv(data,"./tidyData.txt", row.names=FALSE)
}
