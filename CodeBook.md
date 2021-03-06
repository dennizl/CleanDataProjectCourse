# Cook Book for tidyData.csv

This is the cookbook for the tidyData.txt dataset generated by the *run_analysis.R* code, which transforms the _Human Activity Recognition Usiing Smartphones_ datasets provided by the University of California-Irvine into a tidy dataset that can be used for future analysis. The code performing this transformation is contained within this GitHub repository. 

## Background
### File format
The _tidyData.txt_ file is comma seperated and contains a header with the column names. The file is also available as a CSV file (see _tidyData.csv_). There is no difference between these two files other than the file extention.

### Original dataset
The original dataset, _Human Activity Recognition Using Smartphones_, is provided by the University of California - Irvine's Center for Machine Learning and Intelligent Systems. This dataset is described as follows:


```
The [datasets contain the output from] experiments [that] have been carried
out with a group of 30 volunteers within an age bracket of 19-48 years. Each
person performed six activities (WALKING, WALKING_UPSTAIRS, WALKING_DOWNSTAIRS,
SITTING, STANDING, LAYING) wearing a smartphone (Samsung Galaxy S II) on the 
waist. Using its embedded accelerometer and gyroscope, we captured 3-axial linear
acceleration and 3-axial angular velocity at a constant rate of 50Hz. The 
experiments have been video-recorded to label the data manually. The obtained
dataset has been randomly partitioned into two sets, where 70% of the volunteers
was selected for generating the training data and 30% the test data.

The sensor signals (accelerometer and gyroscope) were pre-processed by applying
noise filters and then sampled in fixed-width sliding windows of 2.56 sec and 50% 
overlap (128 readings/window). The sensor acceleration signal, which has 
gravitational and body motion components, was separated using a Butterworth 
low-pass filter into body acceleration and gravity. The gravitational force is 
assumed to have only low frequency components, therefore a filter with 0.3 Hz 
cutoff frequency was used. From each window, a vector of features was obtained by 
calculating variables from the time and frequency domain.
```

This dataset contains the following records:
* Triaxial acceleration from the accelerometer (total acceleration) and the estimated body acceleration. 
* Triaxial Angular velocity from the gyroscope. 
* A 561-feature vector with time and frequency domain variables. 
* Its activity label. 
* An identifier of the subject who carried out the experiment.

For more information, please visit: http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones


## How to reproduce the transformations
The _tidyData.txt_ file is produced by the **run_analysis.R** code. To execute this code, run its **runAnalysis** function, which will perform all the other contained functions needed to produce the tidy dataset from the original UCI smartphone dataset. Note that this function both saves the resulting dataset into a comma-seperated file named _tidyData.txt_ and returns the tidy dataset as a dataframe. The following is the recommended way of running the code once the **run_Analysis.R** file has been sourced in R:

`tidyData <- runAnalysis()`

### Transformations performed to produce the tidy dataset
To transform the dataset into the specified tidy dataset, the code performs the following specific actions, each of which is triggered by a dedicated function held within the *run_Analysis.R* code file:

* Step 1: Loads from file and then merges the training and the test sets to create one data set.
* Step 2: Identifies only the measurements on the mean and standard deviation measurements. 
* Step 3: Extracts only the measurements identified in Step 2.
* Step 4: Adds descriptive activity names to name the activities in the data set.
* Step 5: Creates a second, independent tidy data set with the average of each variable -- for each activity and each subject.
* Step 6: Makes the column names more descriptive in line with best practice naming conventions.
* Step 7: Writes the Tidy dataset to file.


# Description of Variables
The tidy dataset contains 68 variables with 180 observations (as well as a column header). Specifically, the dataset contains averages for 66 smartphone sensor measurements collected on 6 distinct activities performed by 30 unique subjects.

## Identifiers

The identifier columns are:

1. **subject** - this column contains an _integer_ that is unique to one of the 30 subjects
2. **activity** - this column contains a _string_ that identifies 1 of the 6 ctivity performed by the subjects:
  1. WALKING
  2. WALKING_UPSTAIRS
  3. WALKING_DOWNSTAIRS
  4. SITTING
  5. STANDING
  6. LAYING

## Measurements
The dataset contains 66 seperate measurements for each of the 6 activities performed by each of the 30 subjects. The dataset presents the **AVERAGES** of the mean and standard  deviation variables contained in the original dataset (please see the section above, *Background --> Original dataset*, for introductory information on the type of data collected as well as their source and relevant conditions).

Each measurement contained in the tidy dataset is described in the column header, using the following descriptors:

* **time** or **frequency** (all variables): each measurement represents either:
  * time domain signals (*time*), which were captured at a constant rate of 50Hz and filtered using a median filter and a 3rd order low pass Butterworth filter with a corner frequency of 20 Hz to remove noise; or
    * Examples: *timeBodyAccelerometerMean[X,Y,Z]* and *timeBodyGyroscopeJerkStdDev[X,Y,Z]* 
  * the frequency domain signals (*frequency*), which were derived by applying a Fast Fourier Transform (FFT) to some of the signals. 
    * Examples: *frequencyBodyAccelerometerMean[X,Y,Z]* and *frequencyBodyAccelerometerJerkMean[X,Y,Z]* 

* **Body** or **Gravity** (all variables): Each measurement represents either the (*Body*) or gravity (*Gravity*)  acceleration signals into which the data has been seperated using another low pass Butterworth filter with a corner frequency of 0.3 Hz.
  * Examples:  *timeBodyAccelerometerMagnitudeMean* vs. *timeGravityAccelerometerMagnitudeMean* 

* **Accelerometer** or **Gyroscope** (all variables): Each variable represents sensor signal data collected from either the phone's *Accelerometer*, measuring linear acceleration, or the phone's *Gyroscope*, measuring 3-axial angular velocity.

* **Mean** or **StdDev** (all variables): each variable reports on either the average (*Mean*) or the standard deviation (*StdDev*).
  * Examples: *timeBodyGyroscopeMagnitudeMean* vs. *timeBodyGyroscopeMagnitudeStdDev*; and *timeBodyGyroscopeJerkMagnitudeMean* vs.  and *timeBodyGyroscopeJerkMagnitudeStdDev*

* **X**, **Y*, **Z** (select variables): Some column labels conclude with either an *X, Y, or Z*, indicating the axis on which the measurement estimates the feature vector for the relevant pattern. 
  * Examples: *frequencyBodyGyroscopeMeanX*, *frequencyBodyGyroscopeMeanY*, *frequencyBodyGyroscopeMeanZ*

* **Jerk** (select variables): Some variables, which include *Jerk* in the column label, represent jerk signals obtained by the sensors derived from the body linear acceleration and angular velocity.
  * Examples: *timeBodyGyroscopeJerkMeanZ*, timeBodyGyroscopeJerkStdDevX, *timeBodyGyroscopeJerkMagnitudeMean* 

* **Magnitude** (select variables): Some variables, which include the term *Magnitude* in the column label, report the magnitude of the three-dimenisional signals obtained, calculated using the Euclidean norm.
  * Examples: *timeBodyAccelerometerMagnitudeStdDev*, *timeGravityAccelerometerMagnitudeMean*, and *frequencyBodyAccelerometerMagnitudeMean*


Note that each measurement was normalized and bounded within [-1,1]. 
  

## Full List of Variables

1. **subject** (integer: 0:30)
2. **activity** (string of 1 of 6 factors: 1. WALKING, 2. WALKING_UPSTAIRS, 3. WALKING_DOWNSTAIRS, 4. SITTING, 5. STANDING, 6. LAYING)
3. timeBodyAccelerometerMeanX (numeric: between [-1,1])
4. timeBodyAccelerometerMeanY (numeric: between [-1,1])
5. timeBodyAccelerometerMeanZ (numeric: between [-1,1])
6. timeBodyAccelerometerStdDevX (numeric: between [-1,1])
7. timeBodyAccelerometerStdDevY (numeric: between [-1,1])
8. timeBodyAccelerometerStdDevZ (numeric: between [-1,1])
9. timeGravityAccelerometerMeanX (numeric: between [-1,1])
10. timeGravityAccelerometerMeanY (numeric: between [-1,1])
11. timeGravityAccelerometerMeanZ (numeric: between [-1,1])
12. timeGravityAccelerometerStdDevX (numeric: between [-1,1])
13. timeGravityAccelerometerStdDevY (numeric: between [-1,1])
14. timeGravityAccelerometerStdDevZ (numeric: between [-1,1])
15. timeBodyAccelerometerJerkMeanX (numeric: between [-1,1])
16. timeBodyAccelerometerJerkMeanY (numeric: between [-1,1])
17. timeBodyAccelerometerJerkMeanZ (numeric: between [-1,1])
18. timeBodyAccelerometerJerkStdDevX (numeric: between [-1,1])
19. timeBodyAccelerometerJerkStdDevY (numeric: between [-1,1])
20. timeBodyAccelerometerJerkStdDevZ (numeric: between [-1,1])
21. timeBodyGyroscopeMeanX (numeric: between [-1,1])
22. timeBodyGyroscopeMeanY (numeric: between [-1,1])
23. timeBodyGyroscopeMeanZ (numeric: between [-1,1])
24. timeBodyGyroscopeStdDevX (numeric: between [-1,1])
25. timeBodyGyroscopeStdDevY (numeric: between [-1,1])
26. timeBodyGyroscopeStdDevZ (numeric: between [-1,1])
27. timeBodyGyroscopeJerkMeanX (numeric: between [-1,1])
28. timeBodyGyroscopeJerkMeanY (numeric: between [-1,1])
29. timeBodyGyroscopeJerkMeanZ (numeric: between [-1,1])
30. timeBodyGyroscopeJerkStdDevX (numeric: between [-1,1])
31. timeBodyGyroscopeJerkStdDevY (numeric: between [-1,1])
32. timeBodyGyroscopeJerkStdDevZ (numeric: between [-1,1])
33. timeBodyAccelerometerMagnitudeMean (numeric: between [-1,1])
34. timeBodyAccelerometerMagnitudeStdDev (numeric: between [-1,1])
35. timeGravityAccelerometerMagnitudeMean (numeric: between [-1,1])
36. timeGravityAccelerometerMagnitudeStdDev (numeric: between [-1,1])
37. timeBodyAccelerometerJerkMagnitudeMean (numeric: between [-1,1])
38. timeBodyAccelerometerJerkMagnitudeStdDev (numeric: between [-1,1])
39. timeBodyGyroscopeMagnitudeMean (numeric: between [-1,1])
40. timeBodyGyroscopeMagnitudeStdDev (numeric: between [-1,1])
41. timeBodyGyroscopeJerkMagnitudeMean (numeric: between [-1,1])
42. timeBodyGyroscopeJerkMagnitudeStdDev (numeric: between [-1,1])
43. frequencyBodyAccelerometerMeanX (numeric: between [-1,1])
44. frequencyBodyAccelerometerMeanY (numeric: between [-1,1])
45. frequencyBodyAccelerometerMeanZ (numeric: between [-1,1])
46. frequencyBodyAccelerometerStdDevX (numeric: between [-1,1])
47. frequencyBodyAccelerometerStdDevY (numeric: between [-1,1])
48. frequencyBodyAccelerometerStdDevZ (numeric: between [-1,1])
49. frequencyBodyAccelerometerJerkMeanX (numeric: between [-1,1])
50. frequencyBodyAccelerometerJerkMeanY (numeric: between [-1,1])
51. frequencyBodyAccelerometerJerkMeanZ (numeric: between [-1,1])
52. frequencyBodyAccelerometerJerkStdDevX (numeric: between [-1,1])
53. frequencyBodyAccelerometerJerkStdDevY (numeric: between [-1,1])
54. frequencyBodyAccelerometerJerkStdDevZ (numeric: between [-1,1])
55. frequencyBodyGyroscopeMeanX (numeric: between [-1,1])
56. frequencyBodyGyroscopeMeanY (numeric: between [-1,1])
57. frequencyBodyGyroscopeMeanZ (numeric: between [-1,1])
58. frequencyBodyGyroscopeStdDevX (numeric: between [-1,1])
59. frequencyBodyGyroscopeStdDevY (numeric: between [-1,1])
50. frequencyBodyGyroscopeStdDevZ (numeric: between [-1,1])
61. frequencyBodyAccelerometerMagnitudeMean (numeric: between [-1,1])
62. frequencyBodyAccelerometerMagnitudeStdDev (numeric: between [-1,1])
63. frequencyBodyBodyAccelerometerJerkMagnitudeMean (numeric: between [-1,1])
64. frequencyBodyBodyAccelerometerJerkMagnitudeStdDev (numeric: between [-1,1])
65. frequencyBodyBodyGyroscopeMagnitudeMean (numeric: between [-1,1])
66. frequencyBodyBodyGyroscopeMagnitudeStdDev (numeric: between [-1,1])
67. frequencyBodyBodyGyroscopeJerkMagnitudeMean (numeric: between [-1,1])
68. frequencyBodyBodyGyroscopeJerkMagnitudeStdDev (numeric: between [-1,1])
