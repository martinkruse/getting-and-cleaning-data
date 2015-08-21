# CodeBook of course project of Coursera's Getting and Cleaning Data Class
This file describes the data used for this assignment, the variables and information extracted from the original dataset, and all transformations performed.

# Data source

The dataset used for this assignment has been provided by the instructors of the course and can be downloaded from https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip. Further information about the individual variables in this dataset is available here: http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones.

#Extraction and merging of data

The script run_analysis.R first extracts the information what columns of the test and training datasets contain information that represent either "mean" or "standard deviation" values. I defined such columns by searching for the terms "mean" or "std" in all columns of the "features.txt" file of the two datasets with a "grep" command. Afterwards, the information what columns of the datasets contain such information is used to extract these columns from the datasets and to first combine them with the information which of the 30 persons participating in the study it belongs to and, second, what type of the six activities monitored it is associated with. This is done independently for both the testing and the training datasets. Lastly, the two newly created datasets, which contain only columns with data representing either "mean" or "standard deviation" values, are combined by a "rbind" command to generate one new merged data frame.

#Analysis of the merged dataset

In a first step, the script run_analysis.R replaces the number code for the performed activities with a character-based description of the activity. The descriptions of the activities are extracted from the provided file "activity_labels.txt". Afterwards, it calculates the mean for each column of the merged dataset and sorts it by the person having performed one of the six activities monitored. In a last step the script writes the calculated information into a file "tidy_data_set.txt", which can be read and assigned to a data frame named "data" in R with the command "data <- read.table("tidy_data_set.txt", sep = ",")."
  
