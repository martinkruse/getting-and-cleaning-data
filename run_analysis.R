#This script runs under the assumption that the data set has already been downloaded, 
#unpacked, and is present in the working directory in a folder "UCI HAR Dataset".

#The following commands read the three files for the training data set and combine them
#into one data frame.
data_training <- read.table("UCI HAR Dataset/train/X_train.txt", stringsAsFactors = FALSE)
data_training_activities <- read.table("UCI HAR Dataset/train/Y_train.txt", stringsAsFactors = FALSE)
data_training_person <- read.table("UCI HAR Dataset/train/subject_train.txt", stringsAsFactors = FALSE)
data_training_combined_set <- cbind(data_training,data_training_activities, data_training_person)

#The following code reads all three files for the testing data set and combines
#them into one data frame.
data_testing <- read.table("UCI HAR Dataset/test/X_test.txt", stringsAsFactors = FALSE)
data_testing_activities <- read.table("UCI HAR Dataset/test/Y_test.txt", stringsAsFactors = FALSE)
data_testing_person <- read.table("UCI HAR Dataset/test/subject_test.txt", stringsAsFactors = FALSE)
data_testing_combined_set <- cbind(data_testing,data_testing_activities, data_testing_person)

#Combine the training and testing data frame into one combined data frame.
merged_data_set_all_information <- rbind(data_testing_combined_set, data_training_combined_set)

#Read the activities and features into separate data frames.
activity_labels <- read.table("UCI HAR Dataset/activity_labels.txt", stringsAsFactors = FALSE)
features <- read.table("UCI HAR Dataset/features.txt", stringsAsFactors = FALSE)

#The following line extracts a list filled with all the columns containing "mean"
#or "standard deviation" information as defined by "mean" or "std" in the name.
mean_stdev <- grep(".*mean.*|.*std.*", features[,2])
#The following command extracts the names of the columns selected in the previous step.
mean_stdev_column_names <- features[mean_stdev,2]

#The following code renames the labels for the variables to make them more readable.
#For instance, a variable name "xxxx-mean()-XYZ" or "xxxx-std()-XYZ" will be changed to 
#"xxxx-Mean-XYZ" or "xxxx-Std-XYZ", respectively.
mean_stdev_column_names<- gsub("-mean", "-Mean", mean_stdev_column_names)
mean_stdev_column_names <- gsub("-std", "-Std", mean_stdev_column_names)
mean_stdev_column_names <- gsub("\\()", "", mean_stdev_column_names)

#The information stored in "mean_stdev" is used to extract only the columns containing
#means and standard deviations from the merged data frame. It also selects the last two
#columns of the data frame as they contain the information about the type of activity and
#the person performing it.

merged_data_set <- merged_data_set_all_information[,c(mean_stdev,562,563)]

#After the merged data frame has been created, the colnames function is used to assign
#the column names stored in "mean_stdev_column_names" as well as "activity" and
#"person" to the columns of the data frame.
colnames(merged_data_set) <- c(mean_stdev_column_names, "activity", "person")

#Use the information about the type of activity stored in "activity_labels"
#to exchange the number code for the activity to the non-coded description of the 
#activity type.
merged_data_set[, 80] <- activity_labels[merged_data_set[, 80], 2]

#Use the aggregate function to calculate the mean of all columns of the merged data set
#for each activity and person. The function calculates this for all but the last two columns
#as they contain only information about the type of activity and the persons.
calculated_mean = aggregate(merged_data_set[,1:79], by=list(Activity = merged_data_set$activity, Person = merged_data_set$person), mean)

#Write the data into a new file called "tidy_data_set.txt".
write.table(calculated_mean, "tidy_data_set.txt", sep = ",", row.name=FALSE)