# Getting and Cleaning Data Course Project
##run_analysis.R
This script is able to prepare tidy data that can be used for later analysis.  
**Initial data:** *Human Activity Recognition Using Smartphones Data Set*   
from: <http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones>  
Human Activity Recognition database built from the recordings of 30 subjects performing activities  
of daily living while carrying a waist-mounted smartphone with embedded inertial sensors.  
The obtained dataset has been randomly partitioned into two sets, where 70% of the volunteers  
was selected for generating the training data and 30% the test data.
* features.txt: List of all features.  
* activity_labels.txt: Links the class labels with their activity name.  
* train/X_train.txt: Training set.  
* train/y_train.txt: Training labels.  
* test/X_test.txt: Test set.  
* test/y_test.txt: Test labels.  


Used the following packages: *dplyr*, *tidyr*  
**1. Read the untidy data with read.table() function**    
`subject.test<-read.table("UCI HAR Dataset/test/subject_test.txt")`  
`subject.train<-read.table("UCI HAR Dataset/train/subject_train.txt")`  
`X.test<-read.table("UCI HAR Dataset/test/X_test.txt")`  
`X.train<-read.table("UCI HAR Dataset/train/X_train.txt")`  
`Y.test<-read.table("UCI HAR Dataset/test/Y_test.txt")`  
`Y.train<-read.table("UCI HAR Dataset/train/Y_train.txt")`  
`features<-read.table("UCI HAR Dataset/features.txt")`  
**2. Create the *test* set and extract  
only the mean and standard deviation with grep()**  
`test<-cbind(Y.test, subject.test)`  
`names(test)<-c("activity", "subject")`  
`names(X.test) <- features$V2`  
`mean.test<-X.test[grep("mean()", names(X.test), value = TRUE)]`  
`std.test<-X.test[grep("std()", names(X.test), value = TRUE)]`  
`X<-cbind(mean.test, std.test)`  
`TEST<-cbind(test, X)`  
**3. Create the *train* set and extract  
only the mean and standard deviation with grep()**  
`train<-cbind(Y.train, subject.train)`  
`names(train)<-c("activity", "subject")`  
`names(X.train) <- features$V2`  
`mean.train<-X.train[grep("mean()", names(X.train), value = TRUE)]`  
`std.train<-X.train[grep("std()", names(X.train), value = TRUE)]`  
`Y<-cbind(mean.train, std.train)`  
`TRAIN<-cbind(train, Y)`  
**4. Merge the *training* and the *test* sets with the average of each variable   
for each activity and each subject and tidying the data using dplyr and tidyr**  
`TIDY<-rbind(TEST, TRAIN)`  
`TIDY<-gather(TIDY, variable, value, -activity, -subject)`  
`TIDY<-group_by(TIDY, activity, subject, variable)`  
`TIDY<-summarise(TIDY, mean(value))`  
**5. Use descriptive activity names to name the activities**  
`TIDY<-unclass(TIDY)`  
`class(TIDY)<-"data.frame"`  
`TIDY$activity <- as.factor(TIDY$activity)`  
`TIDY$subject <- as.factor(TIDY$subject)`  
`levels(TIDY$activity) <- c("WALKING ", "WALKING_UPSTAIRS", "WALKING_DOWNSTAIRS", "SITTING", "STANDING", "LAYING")`  
**6. Write the tidy data in file**  
`write.table(TIDY, "the_tidy_data_set.txt", row.name=FALSE)`  

#Thank you!

