#You should create one R script called run_analysis.R that does the following. 

library(dplyr)

# 1.Merges the training and the test sets to create one data set.
features <- read.table("UCI HAR Dataset/features.txt")

train_set <- read.table("UCI HAR Dataset/train/X_train.txt", col.names = features[,2])
train_activity <- read.table("UCI HAR Dataset/train/y_train.txt", col.names = "ActivityNr")
train_subject <- read.table("UCI HAR Dataset/train/subject_train.txt", col.names = "SubjectNr")

test_set <- read.table("UCI HAR Dataset/test/X_test.txt", col.names = features[,2])
test_activity <- read.table("UCI HAR Dataset/test/y_test.txt", col.names = "ActivityNr")
test_subject <- read.table("UCI HAR Dataset/test/subject_test.txt", col.names = "SubjectNr")

train_merged <- cbind(train_subject, train_activity, train_set)
test_merged <- cbind(test_subject, test_activity, test_set)
total_merged <- rbind(train_merged, test_merged)

# 2.Extracts only the measurements on the mean and standard deviation for each measurement. 
Total_MSD <- select(total_merged, SubjectNr, ActivityNr, contains("mean"), contains("std"))

# 3.Uses descriptive activity names to name the activities in the data set
activity_labels <- read.table("UCI HAR Dataset/activity_labels.txt", col.names = c("ActivityNr", "ActivityName"))
Total_MSD <- merge(activity_labels, Total_MSD, by="ActivityNr", all.x=TRUE)

# 4.Appropriately labels the data set with descriptive variable names.
colnames(Total_MSD) <- gsub("^t", "Time", colnames(Total_MSD))
colnames(Total_MSD) <- gsub("^f", "Frequency", colnames(Total_MSD))
colnames(Total_MSD) <- gsub("Acc", "Accelerator", colnames(Total_MSD))
colnames(Total_MSD) <- gsub("Gyro", "Gyroscope", colnames(Total_MSD))
colnames(Total_MSD) <- gsub("Mag", "Magnitude", colnames(Total_MSD))
colnames(Total_MSD) <- gsub("Freq", "Frequency", colnames(Total_MSD))

# 5.From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.
Total_Average <- Total_MSD %>% group_by(SubjectNr, ActivityName) %>% summarize_each(funs(mean))
write.table(Total_Average, "TidyData.txt", quote = FALSE ,row.names = FALSE)