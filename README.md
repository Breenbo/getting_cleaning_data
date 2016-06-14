# getting_cleaning_data

## How to make it work
- Unzip the UCI HAR Dataset.zip wherever you want
- DON'T rename the files or the directories
- if the script is in the same directory than the UCI HAR Dataset directory, you don't have to write the path of the UCI HAR Dataset
- to have a dataset with only the measurements on the mean and standard deviation for each measurements, call the *mean_std* function with the path to the UCI HAR Dataset, including "UCI HAR Dataset"
- to create a file.csv with the average of each mean and standard deviation for each activities and each subjects, call the *average_data* function with the path to the UCI HAR Dataset, including "UCI HAR Dataset"


## Functions explanation
The script contains four functions(arguments) :
- *retrieve_path(path)* : reconstruct the path to files from the directory path of UCI data path entered by user
  ! Works only if the files names aren't changed !
- *cleaning(path, theme)* : clean the files and add columns names, rows with subjects and activities
- *mean_std(UCI_dir_path)* : extracting only the measurements on the mean and standard deviation for each measurements
- *average_data(UCI_dir_path)* : create a file.csv with the average of each mean and standard deviation for each activities and each subjects

