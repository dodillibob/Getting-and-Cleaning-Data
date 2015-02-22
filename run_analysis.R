library(dplyr)
library(tidyr)
##Read the data
subject.test<-read.table("UCI HAR Dataset/test/subject_test.txt")
subject.train<-read.table("UCI HAR Dataset/train/subject_train.txt")
X.test<-read.table("UCI HAR Dataset/test/X_test.txt")
X.train<-read.table("UCI HAR Dataset/train/X_train.txt")
Y.test<-read.table("UCI HAR Dataset/test/Y_test.txt")
Y.train<-read.table("UCI HAR Dataset/train/Y_train.txt")
features<-read.table("UCI HAR Dataset/features.txt")
##Create the test set and extract only the mean and standard deviation
test<-cbind(Y.test, subject.test)
names(test)<-c("activity", "subject")
names(X.test) <- features$V2
mean.test<-X.test[grep("mean()", names(X.test), value = TRUE)]
std.test<-X.test[grep("std()", names(X.test), value = TRUE)]
X<-cbind(mean.test, std.test)
TEST<-cbind(test, X)
##Create the train set and extract only the mean and standard deviation
train<-cbind(Y.train, subject.train)
names(train)<-c("activity", "subject")
names(X.train) <- features$V2
mean.train<-X.train[grep("mean()", names(X.train), value = TRUE)]
std.train<-X.train[grep("std()", names(X.train), value = TRUE)]
Y<-cbind(mean.train, std.train)
TRAIN<-cbind(train, Y)
##Merge the training and the test sets and tidying the data
TIDY<-rbind(TEST, TRAIN)
TIDY<-gather(TIDY, variable, value, -activity, -subject)
TIDY<-group_by(TIDY, activity, subject, variable)
TIDY<-summarise(TIDY, mean(value))
##Use descriptive activity names to name the activities
TIDY<-unclass(TIDY)
class(TIDY)<-"data.frame"
TIDY$activity <- as.factor(TIDY$activity)
TIDY$subject <- as.factor(TIDY$subject)
levels(TIDY$activity) <- c("WALKING ", "WALKING_UPSTAIRS", "WALKING_DOWNSTAIRS", "SITTING", "STANDING", "LAYING")
##Write the data
write.table(TIDY, "the_tidy_data_set.txt", row.name=FALSE)
