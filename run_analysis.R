# Source : https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip
# none of the following code would be possible without my friends -
# http://www.statmethods.net/ and http://stackoverflow.com/

# This R script does the following:

# 1. Merges the training and the test sets to create one data set.

#download
dataset_url <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
download.file(dataset_url, "getdata-projectfiles-UCI HAR Dataset.zip")
#unzip
unzip("getdata-projectfiles-UCI HAR Dataset.zip", exdir = "UCI HAR Dataset")

tmp1 <- read.table("train/X_train.txt")
tmp2 <- read.table("test/X_test.txt")
X <- rbind(tmp1, tmp2)

tmp1 <- read.table("train/subject_train.txt")
tmp2 <- read.table("test/subject_test.txt")
S <- rbind(tmp1, tmp2)

tmp1 <- read.table("train/y_train.txt")
tmp2 <- read.table("test/y_test.txt")
Y <- rbind(tmp1, tmp2)

# 2. Extracts only the measurements on the mean and standard deviation for each measurement.

features <- read.table("features.txt")
# measures of interest = m_o_i
m_o_i <- grep("-mean\\(\\)|-std\\(\\)", features[, 2])
X <- X[, m_o_i]
names(X) <- features[m_o_i, 2]
names(X) <- gsub("\\(|\\)", "", names(X))
names(X) <- tolower(names(X))

# 3. Uses descriptive activity names to name the activities in the data set.

activities <- read.table("activity_labels.txt")
activities[, 2] = gsub("_", "", tolower(as.character(activities[, 2])))
Y[,1] = activities[Y[,1], 2]
names(Y) <- "activity"

# 4. Appropriately labels the data set with descriptive activity names.

names(S) <- "subject"
cleaned <- cbind(S, Y, X)
write.table(cleaned, "merged_clean_data.txt")

# 5. Creates a 2nd, independent tidy data set with the average of each variable for each activity and each subject.

uniqueSubjects = unique(S)[,1]
numSubjects = length(unique(S)[,1])
numActivities = length(activities[,1])
numCols = dim(cleaned)[2]
result = cleaned[1:(numSubjects*numActivities), ]

row = 1
for (s in 1:numSubjects) {
  for (a in 1:numActivities) {
    result[row, 1] = uniqueSubjects[s]
    result[row, 2] = activities[a, 2]
    tmp <- cleaned[cleaned$subject==s & cleaned$activity==activities[a, 2], ]
    result[row, 3:numCols] <- colMeans(tmp[, 3:numCols])
    row = row+1
  }
}
write.table(result, "Step 5 - tidy data with averages.txt", row.name=FALSE)


