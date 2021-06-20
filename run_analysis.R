library(tidyr)
library(tidyverse)
library(dplyr)
directory <- "C:/Users/antop/Documents/R/Assignmentcourse3datascience"
unzip(zipfile = paste(directory, "/getdata_projectfiles_UCI HAR Dataset.zip", sep = ""), exdir = directory)

# 1. Merge the data and training test in one data set
  ## Read train datasets
    trainX <- read.table(paste(directory, "/UCI HAR Dataset/train/X_train.txt", sep = ""))
    trainY <- read.table(paste(directory, "/UCI HAR Dataset/train/Y_train.txt", sep = ""))
    subject_train <- read.table(paste(directory, "/UCI HAR Dataset/train/subject_train.txt", sep = ""))            
  
  ## Read test datasets
    testX <- read.table(paste(directory, "/UCI HAR Dataset/test/X_test.txt", sep = ""))
    testY <- read.table(paste(directory, "/UCI HAR Dataset/test/Y_test.txt", sep = ""))
    subject_test <- read.table(paste(directory, "/UCI HAR Dataset/test/subject_test.txt", sep = ""))  
  
  ## Read features and activity labels
    features <- read.table(paste(directory, "/UCI HAR Dataset/features.txt", sep = ""))
    activity_labels <- read.table(paste(directory, "/UCI HAR Dataset/activity_labels.txt", sep = ""))
  
  ##Create headers
    colnames(trainX) <- features[,2]
    colnames(trainY) <- "ActivityId"
    colnames(subject_train) <- "SubjectId"
    colnames(activity_labels) <- c("ActivityId", "ActivityType")
    colnames(testX) <- features[,2]
    colnames(testY) <- "ActivityId"
    colnames(subject_test) <- "SubjectId"
  
  ##Merge datasets
    traindataset <- cbind(subject_train, trainY,  trainX)
    testdataset <- cbind(subject_test, testY, testX)
    alldatasets <- rbind(traindataset, testdataset)           
    
#rm(trainX, trainY, testX, testY, subject_train, subject_test, traindataset, testdataset, features)


#2. Extract only the mean and std
  ##Create a vector with all the columns names
    columns <- colnames(alldatasets)
  ##Create a boolean that checks if the column name is valid (activity, subject, mean, std)
    validcolumns <- (grepl("Activity", columns) | grepl("SubjectId", columns) |grepl("std", columns) | grepl("mean", columns))
  ##Extract the valid columns only
    alldtmeanstd <- alldatasets[ , validcolumns == TRUE]
#rm(alldatasets)

#3. Use descriptive names for the activities
  dtnames <- merge(activity_labels, alldtmeanstd, by="ActivityId", all.x = TRUE)

#4 Label the dataset with descriptive variable names
  names(dtnames)<-gsub("Acc", "Accelerometer", names(dtnames))
  names(dtnames)<-gsub("Gyro", "Gyroscope", names(dtnames))
  names(dtnames)<-gsub("BodyBody", "Body", names(dtnames))
  names(dtnames)<-gsub("Mag", "Magnitude", names(dtnames))
  names(dtnames)<-gsub("^t", "Time", names(dtnames))
  names(dtnames)<-gsub("^f", "Frequency", names(dtnames))
  names(dtnames)<-gsub("tBody", "TimeBody", names(dtnames))
  names(dtnames)<-gsub("-mean()", "Mean", names(dtnames), ignore.case = TRUE)
  names(dtnames)<-gsub("-std()", "STD", names(dtnames), ignore.case = TRUE)
  names(dtnames)<-gsub("-freq()", "Frequency", names(dtnames), ignore.case = TRUE)
  names(dtnames)<-gsub("angle", "Angle", names(dtnames))
  names(dtnames)<-gsub("gravity", "Gravity", names(dtnames))
  
#5 Create a tidy dataset with the average for each activity and subject
  tidydt <- dtnames %>% group_by(SubjectId, ActivityId) %>% summarise_all(funs(mean)) %>% select(!ActivityType)
  tidydt <- merge(activity_labels, tidydt, by="ActivityId", all.x = TRUE)
  tidydt <- tidydt[order(tidydt$SubjectId, tidydt$ActivityId), ]
  write.table(tidydt, "tidydt.txt", row.names = TRUE, col.names = colnames(tidydt))  
