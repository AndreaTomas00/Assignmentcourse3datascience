# Assignmentcourse3datascience 
# GETTING AND CLEANING DATA
Files for the assignment of the third course in the Data Science specialization by the John Hopkins University

In order to run this code:
1. Download the zip file and unzip it in your working directory
2. Download the code (runanalysis.R) in your working directory
3. Run the code

##H2 Data description
The zip file includes data from 30 volunteers (19-48 years old) who performed 6 activities wearing a smartphone on the waist and several features were measured.

## Included files
The data set includes the following files:
- *README.txt*
- *features_info.txt*: Shows information about the variables used on the feature vector.
- *features.txt*: List of all features.
- *activity_labels.txt*: Links the class labels with their activity name.
- *train/X_train.txt*: Training set.
- *train/y_train.txt*: Training labels.
- *test/X_test.txt*: Test set.
- *test/y_test.txt*: Test labels.
- *train/subject_train.txt*: Each row identifies the subject who performed the activity for each window sample. Its range is from 1 to 30. 
- *train/Inertial Signals/total_acc_x_train.txt*: The acceleration signal from the smartphone accelerometer X axis in standard gravity units 'g'. Every row shows a 128 element vector. The same description applies for the 'total_acc_x_train.txt' and 'total_acc_z_train.txt' files for the Y and Z axis. 
- *train/Inertial Signals/body_acc_x_train.txt*: The body acceleration signal obtained by subtracting the gravity from the total acceleration. 
- *train/Inertial Signals/body_gyro_x_train.txt*: The angular velocity vector measured by the gyroscope for each window sample. The units are radians/second. 

## Code explanation
The code follows the instructions given by the assignment and creates a new tidy dataset with both train and test data that includes the average mean and std for each subject and activity.
The final dataset is in the file "tidydt.txt".

## Instructions of the assignment
1. Merges the training and the test sets to create one data set. Use command rbind to combine training and test set
2. Extracts only the measurements on the mean and standard deviation for each measurement. Use grep command to get column indexes for variable name contains "mean()" or "std()"
3. Uses descriptive activity names to name the activities in the data set Convert activity labels to characters and add a new column as factor
4. Appropriately labels the data set with descriptive variable names. Give the selected descriptive names to variable columns
5. From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject. Use pipeline command to create a new tidy dataset with command group_by and summarize_each in dplyr package
