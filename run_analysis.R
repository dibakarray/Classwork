
install.packages("reshape")
library("reshape")

##Concatenate the training and test data sets by combining rows to create the Data set.

training = read.csv("UCI HAR Dataset/train/X_train.txt", sep="", header=FALSE)
testing = read.csv("UCI HAR Dataset/test/X_test.txt", sep="", header=FALSE)
##Data <- rbind(training testing)
##dim(Data) 

##Concatenate the training and test activities by combining rows to create the Activity vector
y_train = read.csv("UCI HAR Dataset/train/Y_train.txt", sep="", header=FALSE)
y_test = read.csv("UCI HAR Dataset/test/Y_test.txt", sep="", header=FALSE)
##Activity <- rbind(y_train , y_test ) 
##dim(Activity) 

##Concatenate the training and test subjects by combining rows to create the Subject vector.

train_subject = read.csv("UCI HAR Dataset/train/subject_train.txt", sep="", header=FALSE)
test_subject = read.csv("UCI HAR Dataset/test/subject_test.txt", sep="", header=FALSE)
##Subject <- rbind(train_subject , test_subject)
##dim(Subject)

# Read features and Standardized feature names with some substitutions
subject_train  = read.csv("UCI HAR Dataset/train/subject_train.txt", sep="", header=FALSE)
subject_test = read.csv("UCI HAR Dataset/test/subject_test.txt", sep="", header=FALSE)
##Subject <- rbind(subject_train , subject_test)
##dim(Subject)
##Get Activity Labels
activityLabels = read.csv("UCI HAR Dataset/activity_labels.txt", sep="", header=FALSE)

## merge y test and training activity labels
  y_train_labels <- merge(y_train,activityLabels ,by="V1")
  y_test_labels <- merge(y_test,activityLabels ,by="V1")


## merge the test and training data and the respective labels together
train_data <- cbind(subject_train,y_train_labels,training)
test_data <- cbind(subject_test,y_test_labels,testing)

## merge test and training data together
Data <- rbind(train_data, test_data )

## Read features and assign variable names to columns of Data 
## features.txt - where V1 is the column number
## and V2 is the actual name
features = read.csv("UCI HAR Dataset/features.txt", sep="", header=FALSE)
features[,2] = gsub('-mean', 'Mean', features[,2])
features[,2] = gsub('-std', 'Std', features[,2])
##features[,2] = gsub("BodyBody","Body",features[,2])
features[,2] = gsub('[-()]', '', features[,2])
## set the column headers for combined data with Subject, activity_id, activity
colnames(Data) <- c("Subject","Activity_Id","Activity",as.vector(features[,2]))

## subset only those rows where the name contains the word mean and std

colsWeWant <- grep(".*Mean.*|.*Std.*", colnames(Data))

# Remove the unwanted columns from Data
Data  <- Data[,c(1,2,3,colsWeWant)]
##The melt function takes data in wide format and stacks a set of columns into a single column of data. To make use of the
## function we need to specify a data frame, the id variables (which will be left at their settings) and
## the measured variables (columns of data) to be stacked. The default assumption on measured variables is that it is all
## columns that are not specified as id variables.
mdata <- melt(Data, id=c("Subject","Activity_Id","Activity"))
  
## cast the data back to the tidy_data format
tidyData <- dcast(mdata, formula = Subject + Activity_Id + Activity ~ variable, mean)
##Write tidy data to a file
write.table(tidyData, file="tidyData.txt", sep="\t", row.names=FALSE)
