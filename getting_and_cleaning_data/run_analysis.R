install.packages("dplyr")
library(dplyr)
zipfile <- tempfile()
download.file("https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip", zipfile)
unzip(zipfile)

# Reading in training data and creating dataframes
featuresDF <- read.table('UCI HAR Dataset/features.txt',header=FALSE)
activityTypeDF <- read.table('UCI HAR Dataset/activity_labels.txt',header=FALSE)
subjectTrainDF <- read.table('UCI HAR Dataset/train/subject_train.txt',header=FALSE)
xTrainDF <- read.table('UCI HAR Dataset/train/x_train.txt',header=FALSE)
yTrainDF <- read.table('UCI HAR Dataset/train/y_train.txt',header=FALSE)

# Assigning column names to the dataframes
colnames(activityTypeDF) <- c('activityId','activityType')
colnames(subjectTrainDF) <- "subjectId"
colnames(xTrainDF)       <- featuresDF[,2]
colnames(yTrainDF)       <- "activityId"

# Creating the final training dataframe
trainingDataDF = cbind(xTrainDF, yTrainDF, subjectTrainDF)

# Reading in test data and creating dataframes
subjectTestDF <- read.table('UCI HAR Dataset/test/subject_test.txt',header=FALSE)
xTestDF <- read.table('UCI HAR Dataset/test/x_test.txt',header=FALSE)
yTestDF <- read.table('UCI HAR Dataset/test/y_test.txt',header=FALSE)

# Assigning column names to the dataframes
colnames(subjectTestDF) <- "subjectId"
colnames(xTestDF) <- featuresDF[,2]
colnames(yTestDF) <- "activityId"

# Creating the final test dataframe
testDataDF <- cbind(xTestDF, yTestDF, subjectTestDF)

# Combining training and test dataframe
finalDataDF <- rbind(trainingDataDF,testDataDF)
colNames  <- colnames(finalDataDF)

# Extracting only the mean and standard deviation for each measurement
meanStdev <- (grepl("activity..",colNames) | grepl("subject..",colNames) | grepl("-mean..",colNames) & !grepl("-meanFreq..",colNames) & !grepl("mean..-",colNames) | grepl("-std..",colNames) & !grepl("-std()..-",colNames))

# Subsetting finalDataDF based on the above Vector
finalDataDF <- finalDataDF[meanStdev==TRUE]

# Merging finalDataDF with acitivityTypeDF to get descriptive names
finalDataDF <- merge(finalDataDF,activityTypeDF,by='activityId',all.x=TRUE)

# Updating the colNames vector to include the new column names after merge
colNames  <- colnames(finalDataDF)

# Cleaning up the variable names
for (i in 1:length(colNames))
{
  colNames[i] <- gsub("\\()","",colNames[i])
  colNames[i] <- gsub("-std$","StdDev",colNames[i])
  colNames[i] <- gsub("-mean","Mean",colNames[i])
  colNames[i] <- gsub("^(t)","time",colNames[i])
  colNames[i] <- gsub("^(f)","freq",colNames[i])
  colNames[i] <- gsub("([Gg]ravity)","Gravity",colNames[i])
  colNames[i] <- gsub("([Bb]ody[Bb]ody|[Bb]ody)","Body",colNames[i])
  colNames[i] <- gsub("[Gg]yro","Gyro",colNames[i])
  colNames[i] <- gsub("AccMag","AccMagnitude",colNames[i])
  colNames[i] <- gsub("([Bb]odyaccjerkmag)","BodyAccJerkMagnitude",colNames[i])
  colNames[i] <- gsub("JerkMag","JerkMagnitude",colNames[i])
  colNames[i] <- gsub("GyroMag","GyroMagnitude",colNames[i])
}

colnames(finalDataDF) = colNames

# Creating dataframe without the activityType column
NoActivityTypeDF <- finalDataDF[,names(finalDataDF) != 'activityType']

# Summarizing the NoActivityType dataframe to include just the mean of each variable for each activity and each subject
tidyDataDF <- aggregate(NoActivityTypeDF[,names(NoActivityTypeDF) != c('activityId','subjectId')],by=list(activityId=NoActivityTypeDF$activityId,subjectId = NoActivityTypeDF$subjectId),mean)

# Merging tidyDataDF with activityType to include descriptive activity names
tidyDataDF <- merge(tidyDataDF, activityTypeDF, by='activityId', all.x=TRUE)
tidyDataDF <- tidyDataDF %>% arrange(activityId, subjectId)

# Exporting tidyDataDF
write.table(tidyDataDF, './tidyData.txt',row.names=TRUE)
