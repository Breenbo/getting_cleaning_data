# 1. Merges the training and the test sets to create one data set.
# 2. Extracts only the measurements on the mean and standard deviation for each 
#    measurement.
# 3. Uses descriptive activity names to name the activities in the data set
# 4. Appropriately labels the data set with descriptive variable names.
# 5. From the data set in step 4, creates a second, independent tidy data set 
#    with the average of each variable for each activity and each subject.

# memento of files
# train/x_train : result per lines - 7352 obs / 561 variables (worked raw variables)
# train/y_train : activities per lines, from 1 to 6 - 7352 obs / 1 column
# train/subject_train : subject per lines, from 1 to 30 - 7352 obs / 1 column
# activity_labels : as title, 6 obs / 2 columns (nb / name)
# features.txt : names of variables - 561 obs / 2 columns (nb / name)
#       mean() : mean value
#       std() : standard deviation

# data frame -> working with dplyr
library(dplyr)
#---------------------------------------------------------
# PLACER SCRIPT et dossier UCI HAR Dataset dans un dossier
# décompresser le zip UCI
# ne pas changer les noms UCI
# setwd dans le dossier contenant le script et UCI
#----------------------------------------------------------------------------
# read and save names in variable "feature"
feature <- read.table("UCI HAR Dataset/features.txt", stringsAsFactors = FALSE)
activity_labels <- read.table("UCI HAR Dataset/activity_labels.txt", 
                              stringsAsFactors = FALSE)
#----------------------------------------------------------------------------
# switching number with names of label in y_train variables
y_train <- read.table("UCI HAR Dataset/train/y_train.txt", 
                      stringsAsFactors = FALSE)
y_train <- as.data.frame(apply(y_train, 2, function(i) activity_labels[i,2]))
names(y_train) <- "activity"
# reading subject number and title
subject_train <- read.table("UCI HAR Dataset/train/subject_train.txt", 
                            stringsAsFactors = FALSE)
names(subject_train) <- "subject"
#----------------------------------------------------------------------------
# switching number with names of label in y_test variables
y_test <- read.table("UCI HAR Dataset/test/y_test.txt", 
                     stringsAsFactors = FALSE)
y_test <- as.data.frame(apply(y_test, 2, function(i) activity_labels[i,2]))
names(y_test) <- "activity"
# reading subject number and title
subject_test <- read.table("UCI HAR Dataset/test/subject_test.txt", 
                           stringsAsFactors = FALSE)
names(subject_test) <- "subject"
#---------------------------------------------------------------------------
# reading, setting names of columns and saving result datas
resultTrain <- read.table("UCI HAR Dataset/train/X_train.txt", 
                          col.names = feature[,2], stringsAsFactors = FALSE)
resultTest <- read.table("UCI HAR Dataset/test/X_test.txt",
                         col.names = feature[,2], stringsAsFactors = FALSE)
#--------------------------------------------------------------------------
# concacenate all values
#--------------------------------------------------------------------------
resultTrain <- cbind(y_train, subject_train, resultTrain)
resultTest <- cbind(y_test, subject_test, resultTest)
result <- rbind(resultTest, resultTrain)
