# Code Book 

## Dataset

The data used as part of this project was downloaded from the UCI Machine Learning Repository and represents a Human Activity Recognition database built from the recordings of 30 subjects performing activities of daily living (standing, walking, etc.) while carrying a waist-mounted smartphone with embedded inertial sensors.

The dataset as well as further information on the experiment is available [here](http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones>).

## Cleaning steps
### Read and combine the data sets

The data was stored in .txt format and read using the `read.table()` function.

The data about the subject of the experiment, the activities performed by the subjects and the different feature measurements were stored in 3 different files, themselves split in train and test datasets.

Data | Train datasets | Test datasets
--- | --- | ---
Subject | subject_train.txt | subject_test.txt
Activity | y_train.txt | y_test.txt
Measurements | X_train.txt | X_test.txt

The first task thus consists in binding (using `rbind()` and `cbind()`) these different files into one single file, including a first column describing the subject, a second column describing the activity performed by that subject and subsequent columns decribing feature measurements.

Lastly, column labels - mostly taken from the file features.txt - were added to the dataset.

The resulting dataset is a 10,299 x 563 dataframe.

### Select only the relevant columns

From this dataset, I only wanted to keep the mean and standard deviation measurements. The names of the columns were explicit enough that I could do this by means of regular expressions (searching for names containing either "mean" or "std").

The resulting dataset is a 10,299 x 81 dataframe.

### Clean variable labels and explicit activities performed

Lastly, I performed the following cleaning steps: 

* Cleaning the variable labels by removing brackets "()", dashes "-" (by substitution) and turning all characters to lower case characters with the `tolower()` function.
* Expliciting the activities performed by replacing activity numbers with their actual descriptions, using the file activity_labels.txt and a combination of the `lapply()` and `match()` functions.

The dimension of the resulting dataframe was unchanged.

### Variables description

The variables contained in the resulting dataframe may be described as follows:

#### Column 1, *integer*: subject

This column describes the subject observed. There are 30 subjects, numbered from 1 to 30.

#### Column 2, *character*: activity

This column describes the activity performed by the subject at the time of the measurement. There are 6 possible activities : walking, walking upstairs, walking downstairs, sitting, standing or laying.

#### Columns 3 to 81, *numeric*: feature measurements

*(extract from features_info.txt)*

The features selected for this database come from the accelerometer and gyroscope 3-axial raw signals tAcc-XYZ and tGyro-XYZ. These time domain signals (prefix 't' to denote time) were captured at a constant rate of 50 Hz. Then they were filtered using a median filter and a 3rd order low pass Butterworth filter with a corner frequency of 20 Hz to remove noise. Similarly, the acceleration signal was then separated into body and gravity acceleration signals (tBodyAcc-XYZ and tGravityAcc-XYZ) using another low pass Butterworth filter with a corner frequency of 0.3 Hz. 

Subsequently, the body linear acceleration and angular velocity were derived in time to obtain Jerk signals (tBodyAccJerk-XYZ and tBodyGyroJerk-XYZ). Also the magnitude of these three-dimensional signals were calculated using the Euclidean norm (tBodyAccMag, tGravityAccMag, tBodyAccJerkMag, tBodyGyroMag, tBodyGyroJerkMag). 

Finally a Fast Fourier Transform (FFT) was applied to some of these signals producing fBodyAcc-XYZ, fBodyAccJerk-XYZ, fBodyGyro-XYZ, fBodyAccJerkMag, fBodyGyroMag, fBodyGyroJerkMag. (Note the 'f' to indicate frequency domain signals). 

These signals were used to estimate variables of the feature vector for each pattern:  
'-XYZ' is used to denote 3-axial signals in the X, Y and Z directions.

* tBodyAcc-XYZ
* tGravityAcc-XYZ
* tBodyAccJerk-XYZ
* tBodyGyro-XYZ
* tBodyGyroJerk-XYZ
* tBodyAccMag
* tGravityAccMag
* tBodyAccJerkMag
* tBodyGyroMag
* tBodyGyroJerkMag
* fBodyAcc-XYZ
* fBodyAccJerk-XYZ
* fBodyGyro-XYZ
* fBodyAccMag
* fBodyAccJerkMag
* fBodyGyroMag
* fBodyGyroJerkMag

The set of variables that were estimated from these signals are: 

* mean(): Mean value
* std(): Standard deviation

## Analytics

As a last step, I perform some analytics on the clean dataset using the **dplyr** package to calculate the mean of each of the 79 types of feature measurements to find their mean per subject per activity, i.e. calculate 30 (number of subjects) x 6 (number of activities) = 180 means for each type of feature measurements.

Hence, the resulting table is a 180 x 81 dataframe.
