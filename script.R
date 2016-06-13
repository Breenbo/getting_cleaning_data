# 1. Merges the training and the test sets to create one data set.
# 2. Extracts only the measurements on the mean and standard deviation for each 
#    measurement.
# 3. Uses descriptive activity names to name the activities in the data set
# 4. Appropriately labels the data set with descriptive variable names.
# 5. From the data set in step 4, creates a second, independent tidy data set 
#    with the average of each variable for each activity and each subject.

# memento of files
# train/X_train : result per lines - 7352 obs / 561 variables (worked raw variables)
# train/y_train : activities per lines, from 1 to 6 - 7352 obs / 1 column
# train/subject_train : subject per lines, from 1 to 30 - 7352 obs / 1 column
# activity_labels : as title, 6 obs / 2 columns (nb / name)
# features.txt : names of variables - 561 obs / 2 columns (nb / name)
#       mean() : mean value
#       std() : standard deviation

# data frame -> working with dplyr !!!
library(dplyr)
#---------------------------------------------------------
# décompresser le zip UCI
# si le script dans le même dossier que UCI, juste mean_std()
# si le script dans répertoire différent, mean_std(UCI_dir_path)
#----------------------------------------------------------------------------
# function to retrieve text files
#----------------------------------------------------------------------------
retrieve_path <- function(path) {
        dir_feature <- paste(path, "features.txt", sep = "/")
        dir_activity_label <- paste(path, "activity_labels.txt", sep = "/")
        x <- c("train", "test")
        dir_app <- lapply(x, function(x) {
                dir_y <- paste(path,"/", x,"/", "y_",x,".txt", sep="")
                dir_subject <- paste(path,"/", x,"/", "subject_",x,".txt", 
                                     sep="")
                dir_result <- paste(path,"/", x,"/", "X_",x,".txt", sep="")
                dir_app <- c(subject = dir_subject, y = dir_y, 
                             result = dir_result)
        })
        dir_path <- c(activity = dir_activity_label,feature = dir_feature, 
                      train = dir_app[1], test = dir_app[2])
        return(dir_path)
}
#----------------------------------------------------------------------------
# cleaning and merging the datasets, and labelling them, for train and test
#----------------------------------------------------------------------------
cleaning <- function(path, theme) {
        #-----------------------------------------------------------------------
        # read and save names in variable "feature"
        feature <- read.table(retrieve_path(path)$feature, 
                              stringsAsFactors = FALSE, header = FALSE,
                              colClasses = "character")
        activity_labels <- read.table(retrieve_path(path)$activity, 
                                      stringsAsFactors = FALSE, header = FALSE)
        #---------------------------------------------------------------------------
        # reading, setting names of columns and saving result datas
        result_theme <- read.table(retrieve_path(path)[[theme]][["result"]], 
                                  col.names = feature[,2], 
                                  stringsAsFactors = FALSE,
                                  header = FALSE,
                                  colClasses = "numeric") #improve read.table
        #-----------------------------------------------------------------------
        # switching number with names of label in y_train variables
        y_theme <- read.table(retrieve_path(path)[[theme]][["y"]], 
                              stringsAsFactors = FALSE, header = FALSE, 
                              colClasses = "numeric")
        y_theme <- as.data.frame(apply(y_theme, 2, 
                                       function(i) activity_labels[i,2]))
        names(y_theme) <- "activity"
        # reading subject number and title
        subject_theme <- read.table(retrieve_path(path)[[theme]][["subject"]], 
                                    stringsAsFactors = FALSE, header = FALSE,
                                    colClasses = "numeric")
        names(subject_theme) <- "subject"
        if (theme == "train") {
                y_train <- y_theme
                subject_train <- subject_theme
                result_train <- result_theme
                resultTrain <- cbind(y_train, subject_train, result_train)
                return(resultTrain)
        }
        if (theme == "test") {
                y_test <- y_theme
                subject_test <- subject_theme
                result_test <- result_theme
                resultTest <- cbind(y_test, subject_test, result_test)
                return(resultTest)
        }
}
#----------------------------------------------------------------------------
# merging datasets to have tidy one, then extract only mean and std columns
#----------------------------------------------------------------------------
mean_std <- function(UCI_dir_path = "UCI HAR Dataset") {
        # merge all values in one tidy dataset
        result <- rbind.data.frame(cleaning(UCI_dir_path,"test"), 
                                   cleaning(UCI_dir_path, "train"), 
                                   stringsAsFactors = FALSE)
        # searching names of mean and std
        noms <- names(result)
        noms_mean_std <- noms[grepl("activity|subject|mean|std",noms)]
        # extracting only the measurements on the mean and standard deviation 
        # for each measurement
        result_mean_std <- select(result, one_of(noms_mean_std))
        return(result_mean_std)
}
#----------------------------------------------------------------------------
# function to mean all the values for each activity and each subject
# write results in dataset .csv
#----------------------------------------------------------------------------
average_data <- function(UCI_dir_path = "UCI HAR Dataset") {
        average_dataset <- mean_std(UCI_dir_path)
        average_dataset <- group_by(average_dataset, activity, subject)
        average_dataset <- summarise_each(average_dataset, funs(mean))
        write.csv(average_dataset, file = "average_dataset.csv", 
                  col.names = TRUE, row.names = TRUE)
}

