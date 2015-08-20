#This script runs under the assumption that the data set has already been downloaded, 
#unpacked, and is present in the working directory in a folder "UCI HAR Dataset".


#Read the activities and features into separate data frames.
activity_labels <- read.table("UCI HAR Dataset/activity_labels.txt", stringsAsFactors = FALSE)
features <- read.table("UCI HAR Dataset/features.txt", stringsAsFactors = FALSE)

#The following line extracts a list filled with all the columns containing "mean"
#or "standard deviation" information as defined by "mean" or "std" in the name.
mean_stdev <- grep(".*mean.*|.*std.*", features[,2])
#The following command extracts the names of the columns selected in the previous step.
mean_stdev_column_names <- features[mean_stdev,2]

#The information stored in "mean_stdev" is used to extract only the data regarding
#means and standard deviations from the training and testing data sets. This is done
#first for the measured values, second for the type of activity, and last for the person
#undergoing the activity. Afterwards, the cbind function is used to combine the three
#data frames to one data frame. Lastly, the rbind function is used to combine the two
#data sets into one merged data frame containing the information from both the
#training and testing data sets.
data_training <- read.table("UCI HAR Dataset/train/X_train.txt")[mean_stdev]
data_training_activities <- read.table("UCI HAR Dataset/train/Y_train.txt")
data_training_person <- read.table("UCI HAR Dataset/train/subject_train.txt")
data_training_combined_set <- cbind(data_training,data_training_activities, data_training_person)
data_testing <- read.table("UCI HAR Dataset/test/X_test.txt")[mean_stdev]
data_testing_activities <- read.table("UCI HAR Dataset/test/Y_test.txt")
data_testing_person <- read.table("UCI HAR Dataset/test/subject_test.txt")
data_testing_combined_set <- cbind(data_testing,data_testing_activities, data_testing_person)
merged_data_set <- rbind(data_testing_combined_set, data_training_combined_set)

#After the merged data frame has been created, the colnames function is used to assign
#the column names stored in "mean_stdev_column_names" as well as "activity" and
#"person" to columns of the data frame.
colnames(merged_data_set) <- c(mean_stdev_column_names, "activity", "person")

#Use the information about the type of activity stored in "activity_labels"
#to exchange the number code for the activity to the non-coded description of the 
#activity type.
merged_data_set[, 80] <- activity_labels[merged_data_set[, 80], 2]

#Convert the entries for activities and persons into factors.
merged_data_set$activity <- as.factor(merged_data_set$activity)
merged_data_set$person <- as.factor(merged_data_set$person)

#Use the aggregate function to calculate the mean of all columns of the merged data set
#for each activity and person. The function calculates this for all but the last two columns
#as they contain only information about the type of activity and the persons.
calculated_mean = aggregate(merged_data_set[,1:79], by=list(Activity = merged_data_set$activity, Person = merged_data_set$person), mean)

#Write the data into a new file called "tidy_data_set.txt".
write.table(calculated_mean, "tidy_data_set.txt", sep = ",", row.name=FALSE)