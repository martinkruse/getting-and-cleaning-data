# CodeBook of course project of Coursera's Getting and Cleaning Data Class
This file describes the data used for this assignment, the variables and information extracted from the original dataset, and all transformations performed.

# Data source

The dataset used for this assignment has been provided by the instructors of the course and can be downloaded from https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip. Further information about the individual variables in this dataset is available here: http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones.

#Extraction and merging of data

The script run_analysis.R first reads the three files containing all necessary information for both the training and the testing data sets. These three files have the following information: Measured values, type of activity performed, and the person having performed it. The information from these three files gets combined into one data frame. After this is done for both data sets the newly created data frames are combined to one data frame.

Next, the script run_analysis.R uses a "grep" command to search for all columns in this merged data frame that contain information regarding either "mean" or "standard deviation" values. I defined such columns by searching for the terms "mean" or "std" in all columns of the "features.txt" file. This information is used to subset the data frame with all information in it to create a new data frame that contains only the columns from the original data frame with information about "mean" and "standard deviation" values. In addition, this data frame still contains two columns with the information about the type of activity performed and the person having performed it.

#Analysis of the merged dataset

In the following step, the script run_analysis.R replaces the number code for the performed activities with a character-based description of the activity. The descriptions of the activities are extracted from the provided file "activity_labels.txt". Afterwards, it calculates the mean for each column of the merged dataset and sorts it by the person having performed one of the six activities monitored. In a last step the script writes the calculated information into a file "tidy_data_set.txt", which can be read and assigned to a data frame named "data" in R with the command "data <- read.table("tidy_data_set.txt", sep = ",")."

#Dimensions of data points and units
Please note that all data has been normalized to a range of -1 to +1 by the creators of the data set. Because of this all values are without units.
  
