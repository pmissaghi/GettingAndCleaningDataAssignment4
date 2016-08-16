  #Load train
  subject_train = read.table("UCI HAR Dataset/train/subject_train.txt")
  X_train = read.table("UCI HAR Dataset/train/X_train.txt")
  Y_train = read.table("UCI HAR Dataset/train/Y_train.txt")
  
  #Load test 
  subject_test = read.table("UCI HAR Dataset/test/subject_test.txt")
  X_test = read.table("UCI HAR Dataset/test/X_test.txt")
  Y_test = read.table("UCI HAR Dataset/test/Y_test.txt")
  
  
  # Get activities
  activity_labels <- read.table("UCI HAR Dataset/activity_labels.txt", col.names=c("activityCode", "activity"))
  activity_labels$activity <- gsub("_", "", as.character(activity_labels$activity))
  
  # Get features
  features <- read.table("UCI HAR Dataset/features.txt", col.names=c("featureCode", "feature"))
  
  #Filter for features related to mean and standard deviation
  usedFeatureCodes <- grep("-mean\\(\\)|-std\\(\\)", features$feature)
  
  # merge data from test and train
  merged_dataset <- rbind(subject_train, subject_test)
  names(merged_dataset) <- "subjectCode"
  Y <- rbind(Y_test, Y_train)
  names(Y) = "activityCode"
  activity <- merge(Y, activity_labels, by="activityCode")$activity
  
  
  X <- rbind(X_test, X_train)
  X <- X[, usedFeatureCodes]
  names(X) <- gsub("\\(|\\)", "", features$feature[usedFeatureCodes])
  
  mergedData <- cbind(merged_dataset, X, activity)
  write.table(mergedData, "merged_data.txt")

  