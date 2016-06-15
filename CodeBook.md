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
