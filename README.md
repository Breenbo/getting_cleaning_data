# Getting and Cleaning Datasets - R script

## How to make it work
- Unzip the UCI HAR Dataset.zip wherever you want
- DON'T rename the files or the directories
- if the script is in the same directory than the UCI HAR Dataset directory, you don't have to write the path of the UCI HAR Dataset
- to have a dataset with only the measurements on the mean and standard deviation for each measurements, call *mean_std(path to the UCI HAR Dataset, including "UCI HAR Dataset"
)*
- to create a csv file with the average of each mean and standard deviation for each activities and each subjects, call *average_data(path to the UCI HAR Dataset, including "UCI HAR Dataset")*


## Functions explanation
The script contains four functions(arguments) :
- *retrieve_path(path)* :
  - reconstruct the path to files from the directory path of "UCI HAR Dataset" entered by user.
  - Work only if the files names aren't changed !
- *cleaning(path, theme)* : clean the files "train" and "test" and add columns names, rows with subjects and activities
- *mean_std(UCI_dir_path)* :
  - extract only the measurements on the mean and standard deviation for each measurements,
  - take the files returned by the *cleaning* function and merge them in a unique dataset.
- *average_data(UCI_dir_path)* :
  - create a file.csv with the average of each mean and standard deviation for each activities and each subjects
  - take the file returned by the *mean_std* function
  - calculate the mean of each columns
  - write a csv file with the results in the directory of the script

