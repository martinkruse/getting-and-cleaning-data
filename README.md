# README of course project of Coursera's Getting and Cleaning Data Class
This repository contains all of my files for the course project of Coursera's Getting and Cleaning Data class.

It contains the following files:

  1. run_analysis.R: This is the script that runs all functions necessary for the assignment.
  2. tidy_data_set.txt: This file is the output of run_analysis.R and contains a tidy dataset with the mean values requested by the assignment.
  3. CodeBook.md: This file describes the variables, the data, and all transformations performed.
  
# Requirements

The script run_analysis.R requires the dataset to be downloaded and available on the computer run_analysis.R is to be used on.
The dataset should be unpacked and the script run_analysis.R should be on the top level of the dataset. Further instructions on the usage of run_analysis.R can also be found as comments in the file itself.

#Functionality of run_analysis.R

The script extracts all data containing information about "mean" and "standard deviation" values from the testing and training datasets and merges them into one new data frame. It renames the labels of variables to make them more readable. Afterwards, it calculates the mean values for each parameter present in the new data frame based on two criteria:

  1. It calculates these values for every person that has participated in the study.
  2. For every person, it calculates the mean values for all parameters in six different categories of activities.
  
Further information about the data and the variables can be found in CodeBook.md.
  
