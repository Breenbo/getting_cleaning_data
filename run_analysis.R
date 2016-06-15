library(dplyr)
#----------------------------------------------------------------------------
# function to retrieve text files
#----------------------------------------------------------------------------
retrieve_path <- function(path) {
        files_names <- list.files(path, recursive = TRUE, full.names = TRUE)
        x <- c("features.txt","activity_labels.txt","train/y_train",
               "test/y_test", "subject_train", "subject_test", "X_train",
               "X_test")
        dir_path <- sapply(x, function(x){
                files_names[grep(x, files_names)]
        })
        return(dir_path)
}
#----------------------------------------------------------------------------
# cleaning and merging the datasets, and labelling them, for train and test
#----------------------------------------------------------------------------
cleaning <- function(path) {
        #-----------------------------------------------------------------------
        # read, clean and save names in variable "feature"
        #----------------------------------------------------------------------
        feature <- read.table(retrieve_path(path)["features.txt"],
                              stringsAsFactors = FALSE, header = FALSE,
                              colClasses = "character")
        feature <- feature[,2]
        #-----------------------------------------------------------------------
        # cleaning the names of columns and made them valid/unique
        #----------------------------------------------------------------------
        feature <- gsub("[-,]","_", feature)
        feature <- gsub("[()]","", feature)
        feature <- gsub("mean", "Mean", feature)
        feature <- gsub("Acc", "_Acc_", feature)
        feature <- gsub("Gyro", "_Gyro_", feature)
        feature <- gsub("angle", "angle_", feature)
        feature <- gsub("__", "_", feature)
        feature <- make.names(feature, unique = TRUE)
        #----------------------------------------------------------------------
        activity_labels <- read.table(retrieve_path(path)["activity_labels.txt"],
                                      stringsAsFactors = FALSE, header = FALSE)
        #-----------------------------------------------------------------------
        # reading files and saving result datas in list of dataframes
        #-----------------------------------------------------------------------
        theme_name <- c("train/y_train","test/y_test","subject_train",
                        "subject_test","X_train","X_test")
        result <- lapply(theme_name, function(x) {
                        read.table(retrieve_path(path)[x],
                        stringsAsFactors = FALSE,
                        header = FALSE,
                        colClasses = "numeric") #improve read.table
               })
        names(result) <- theme_name
        #-----------------------------------------------------------------------
        # ordering and merging datas in one dataframe
        #-----------------------------------------------------------------------
        train <- c("train/y_train","subject_train","X_train")
        result_train <- cbind(as.data.frame(result[train]))
        names(result_train) <- c("activity", "subject", feature)
        test <- c("test/y_test","subject_test", "X_test")
        result_test <- cbind(as.data.frame(result[test]))
        names(result_test) <- c("activity", "subject", feature)
        #----------------------------------------------------------------------
        total_result <- rbind.data.frame(result_test,result_train,
                                         stringsAsFactors = FALSE)
        #-----------------------------------------------------------------------
        # switching number with names of label in y_train variables
        #-----------------------------------------------------------------------
        for (i in 1:6) {
                total_result$activity <- gsub(i, activity_labels[i,2],
                                              total_result$activity)
        }
        return(total_result)
}
#-------------------------------------------------------------------------------
# using tidy one dataset, and extract only mean and std columns
#-------------------------------------------------------------------------------
mean_std <- function(UCI_dir_path = "UCI HAR Dataset") {
        # searching names of mean and std
        total_result <- cleaning(UCI_dir_path)
        result_mean_std <- select(total_result, activity, subject,
                                  contains("Mean"), contains("std"))
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
