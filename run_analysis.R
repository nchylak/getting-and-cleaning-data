### Merge the training and the test sets to create one data set

## Train
# Read
xtrain <- read.table("UCI HAR Dataset/train/X_train.txt") # other variables
ytrain <- read.table("UCI HAR Dataset/train/y_train.txt") # activity
subjtrain <- read.table("UCI HAR Dataset/train/subject_train.txt") # subject
# Assemble
train <- cbind(subjtrain, ytrain)
train <- cbind(train, xtrain)
remove(subjtrain, ytrain, xtrain) # For saving memory

## Test
# Read
xtest <- read.table("UCI HAR Dataset/test/X_test.txt") # other variables
ytest<- read.table("UCI HAR Dataset/test/y_test.txt") # activity
subjtest <- read.table("UCI HAR Dataset/test/subject_test.txt") # subject
# Assemble
test <- cbind(subjtest, ytest)
test <- cbind(test, xtest)
remove(subjtest, ytest, xtest) # For saving memory

## Train + Test
table <- rbind(train, test)
remove(train, test) # For saving memory

## Add header
features <- read.table("UCI HAR Dataset/features.txt")
features <- as.vector(features[,"V2"])
features <- c(c("subject", "activity"), features)
names(table) <- features

### Extract only the measurements on the mean and standard deviation for each measurement

## Get column names
meanstd <- grep("mean|std", features, value = TRUE)
cols <- c(c("subject", "activity"), meanstd)

## Filter
table <- table[,cols]

### Use descriptive activity names to name the activities in the data set

## Read activity names
activ <- read.table("UCI HAR Dataset/activity_labels.txt")

## Replace 
table$activity <- lapply(table$activity, function(x) as.character(activ$V2[match(x, activ$V1)]))
table$activity <- as.character(table$activity)

### Appropriately label the dataset
names(table) <- gsub("()", "", names(table), fixed = TRUE)
names(table) <- gsub("-", "", names(table), fixed = TRUE)
names(table) <- tolower(names(table))

### Average of each variable for each activity and each subject
library(dplyr)
summary <- table %>% group_by(subject, activity) %>% summarise_all(mean)
write.table(summary, "summary.txt", row.names = FALSE)
