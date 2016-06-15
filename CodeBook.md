# CodeBook

## Functions explanation :
The script, which uses the dplyr package, contains four functions(arguments) :
- *retrieve_path(UCI_dir_path)* :
  - reconstruct the path to files from the directory path of "UCI HAR Dataset" entered by user.
  - Work only if the files names aren't changed !
- *cleaning(UCI_dir_path)* :
  - clean the files "train" and "test" and, add columns names, and add rows with subjects and activities
  - return a clean dataset with train and test values, subject number and names of activities
- *mean_std(UCI_dir_path)* :
  - extract only the measurements on the mean and standard deviation for each measurements,
  - take the file returned by the *cleaning* function
- *average_data(UCI_dir_path)* :
  - create a file.csv with the average of each mean and standard deviation for each activities and each subjects
  - take the file returned by the *mean_std* function
  - calculate the mean of each columns
  - write a csv file with the results in the directory of the script

## Data manipulations explanations
Working with the following files :
- *features.txt* : indicates the names of the 561 variables
- *activity_labels.txt* : indicates the names of the 6 possible activities
- *y_train.txt* : indicates activities per lignes, from 1 to 6, for each of the 7352 train observations
- *y_test.txt* : indicates activities per lignes, from 1 to 6, for each of the 2947 test observations
- *subject_train.txt* : indicates subject per lignes, from 1 to 30, for each of the 7352 train observations
- *subject_test.txt* : indicates subject per lignes, from 1 to 30, for each of the 2947 test observations
- *X_train.txt* : indicates the values of the 561 variables for each of the 7351 train observations
- *X_test.txt* : indicates the values of the 561 variables for each of the 2947 test observations

Script consist of merging the X_train and X_test files. This files are the resampled datas from all the files in the Inertial directories.
Then, it add the columns subject (from the subject_train and subject_test files) and activities (from the y_test and y_train).
The names of the activities are extracted from the activities_label file.
The name of the 561 columns are extracted from the features file.
**It result a tidy dataset from all of the resampled variables for all of the observations.**

Then the mean and the std columns are extracted.
Finally, a new dataset is created with the average of each mean and standard deviation for each activities and each subjects

## datas and units
### units
- Acc(3-axial linear acceleration) : g
- Gyro(3-axial angular velocity) : rad/s
- angle : rad

### data names
- mean(): Mean value
- std(): Standard deviation
- tBody_Acc_Mean_X
- tBody_Acc_Mean_Y
- tBody_Acc_Mean_Z
- tGravity_Acc_Mean_X
- tGravity_Acc_Mean_Y
- tGravity_Acc_Mean_Z
- tBody_Acc_Jerk_Mean_X
- tBody_Acc_Jerk_Mean_Y
- tBody_Acc_Jerk_Mean_Z
- tBody_Gyro_Mean_X
- tBody_Gyro_Mean_Y
- tBody_Gyro_Mean_Z
- tBody_Gyro_Jerk_Mean_X
- tBody_Gyro_Jerk_Mean_Y
- tBody_Gyro_Jerk_Mean_Z
- tBody_Acc_Mag_Mean
- tGravity_Acc_Mag_Mean
- tBody_Acc_JerkMag_Mean
- tBody_Gyro_Mag_Mean
- tBody_Gyro_JerkMag_Mean
- fBody_Acc_Mean_X
- fBody_Acc_Mean_Y
- fBody_Acc_Mean_Z
- fBody_Acc_MeanFreq_X
- fBody_Acc_MeanFreq_Y
- fBody_Acc_MeanFreq_Z
- fBody_Acc_Jerk_Mean_X
- fBody_Acc_Jerk_Mean_Y
- fBody_Acc_Jerk_Mean_Z
- fBody_Acc_Jerk_MeanFreq_X
- fBody_Acc_Jerk_MeanFreq_Y
- fBody_Acc_Jerk_MeanFreq_Z
- fBody_Gyro_Mean_X
- fBody_Gyro_Mean_Y
- fBody_Gyro_Mean_Z
- fBody_Gyro_MeanFreq_X
- fBody_Gyro_MeanFreq_Y
- fBody_Gyro_MeanFreq_Z
- fBody_Acc_Mag_Mean
- fBody_Acc_Mag_MeanFreq
- fBodyBody_Acc_JerkMag_Mean
- fBodyBody_Acc_JerkMag_MeanFreq
- fBodyBody_Gyro_Mag_Mean
- fBodyBody_Gyro_Mag_MeanFreq
- fBodyBody_Gyro_JerkMag_Mean
- fBodyBody_Gyro_JerkMag_MeanFreq
- angle_tBody_Acc_Mean_gravity
- angle_tBody_Acc_JerkMean_gravityMean
- angle_tBody_Gyro_Mean_gravityMean
- angle_tBody_Gyro_JerkMean_gravityMean
- angle_X_gravityMean
- angle_Y_gravityMean
- angle_Z_gravityMean
- tBody_Acc_std_X
- tBody_Acc_std_Y
- tBody_Acc_std_Z
- tGravity_Acc_std_X
- tGravity_Acc_std_Y
- tGravity_Acc_std_Z
- tBody_Acc_Jerk_std_X
- tBody_Acc_Jerk_std_Y
- tBody_Acc_Jerk_std_Z
- tBody_Gyro_std_X
- tBody_Gyro_std_Y
- tBody_Gyro_std_Z
- tBody_Gyro_Jerk_std_X
- tBody_Gyro_Jerk_std_Y
- tBody_Gyro_Jerk_std_Z
- tBody_Acc_Mag_std
- tGravity_Acc_Mag_std
- tBody_Acc_JerkMag_std
- tBody_Gyro_Mag_std
- tBody_Gyro_JerkMag_std
- fBody_Acc_std_X
- fBody_Acc_std_Y
- fBody_Acc_std_Z
- fBody_Acc_Jerk_std_X
- fBody_Acc_Jerk_std_Y
- fBody_Acc_Jerk_std_Z
- fBody_Gyro_std_X
- fBody_Gyro_std_Y
- fBody_Gyro_std_Z
- fBody_Acc_Mag_std
- fBodyBody_Acc_JerkMag_std
- fBodyBody_Gyro_Mag_std
- fBodyBody_Gyro_JerkMag_std
