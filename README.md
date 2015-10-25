#Course Name - Getting and Cleaning Data#
###Course Project "Collect,  clean and work with  Human Activity Recognition Using Smartphones Data Set"###
#####Data Set Description is available [here](http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones)#####
Data is available [here](https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip)
Download the zip file from this URL.
Unzip the file into a directory. Set the Directory as Working Directory using setwd command. Unzip creates a data directory named **'UCI HAR Dataset'**
Do not change name of the data directory.

Here are the steps that must be performed before running the R script:

Once those steps are complete, you can run the R script (run_analysis.R). Note that it requires the reshape2 package, which can be downloaded from CRAN using the command 
install.packages("reshape") and library("reshape")

The output of the R script is a tidy data set, tidyData.txt. Each column of the data set is seperated by tab.

You can read more about the data and the analysis in the code book.