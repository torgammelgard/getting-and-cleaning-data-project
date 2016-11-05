library(data.table)
library(reshape2)

### Download and unzip the file and set the path
f <- "getdata_dataset.zip"

if (!file.exists(f)){
  url <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip "
  download.file(url, f, method="curl", mode = "w")
}  
if (!file.exists("UCI HAR Dataset")) { 
  unzip(f)
}

path <- getwd()

###
activityLabels <- read.table("UCI HAR Dataset/activity_labels.txt")
activityLabels[,2] <- as.character(activityLabels[,2])

features <- read.table("UCI HAR Dataset/features.txt")
features[,2] <- as.character(features[,2])

meanstdfeatures <- grep(".*mean.*|.*std.*", features[,2])
meanstdfeatures.names <- features[meanstdfeatures,2]
meanstdfeatures.names = gsub('-mean', 'Mean', meanstdfeatures.names)
meanstdfeatures.names = gsub('-std', 'Std', meanstdfeatures.names)
meanstdfeatures.names <- gsub('[-()]', '', meanstdfeatures.names)

### Read the data
dtSubjectTrain <- read.table(file.path(path, "UCI HAR Dataset", "train", "subject_train.txt"))
dtActivityTrain <- read.table(file.path(path, "UCI HAR Dataset", "train", "Y_train.txt"))
dtTrain <- read.table(file.path(path, "UCI HAR Dataset/train/X_train.txt"))[meanstdfeatures]

dtSubjectTest <- read.table(file.path(path, "UCI HAR Dataset", "test", "subject_test.txt"))
dtActivityTest <- read.table(file.path(path, "UCI HAR Dataset", "test", "Y_test.txt"))
dtTest <- read.table(file.path(path, "UCI HAR Dataset/test/X_test.txt"))[meanstdfeatures]

train <- cbind(dtSubjectTrain, dtActivityTrain, dtTrain)
test <- cbind(dtSubjectTest, dtActivityTest, dtTest)

###
dt <- rbind(train, test)
colnames(dt) <- c("subject", "activity", meanstdfeatures.names)

### Make subjects and activites into factors
dt$activity <- factor(dt$activity, levels = activityLabels[,1], labels = activityLabels[,2])
dt$subject <- as.factor(dt$subject)

dt.melted <- melt(dt, id = c("subject", "activity"))
dt.mean <- dcast(dt.melted, subject + activity ~ variable, mean)

write.table(allData.mean, "tidy.txt", row.names = FALSE, quote = FALSE)