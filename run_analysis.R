#Getting and Cleaning Data - Coursera 
#Peer graded assignment by Milena

#In order to create the tidy data set as required in the assignment
#I first installed a package called "dplyr" because it provides some 
#tools for better manipulating datasets in R

#After downloading the dataset, I could see that there are couple of
#sets that we should extract and merge: features.txt, activity_labels.text,
#subject_test.txt, X_test.txt, Y_test.txt, subject_train.txt, X_train.txt 
#and Y_train.txt


#The first step of the assignment is to merge the training and
#test sets to create one data set
#These data sets are already in the downloaded file

Xgeneral <- rbind(x_train, x_test)
Y <- rbind(y_train, y_test)
Subject <- rbind(subject_train, subject_test)
Merged_Data <- cbind(Subject, Y, X)

#The second step of the assignment is to extract only the measurements
# on the mean and standard deviation for each measurement

TidyData <- Merged_Data %>% select(subject, code, contains("mean"), contains("std"))

#The third step of the assigmnet is to use descriptive names
#to name the activities in the data set

TidyData$code <- activities[TidyData$code, 2]
 
#The fourth step of the assignment is to label appropriately
#the data set with descriptive variable names

names(TidyData)[2] = "activity"
names(TidyData)<-gsub("Acc", "Accelerometer", names(TidyData))
names(TidyData)<-gsub("Gyro", "Gyroscope", names(TidyData))
names(TidyData)<-gsub("BodyBody", "Body", names(TidyData))
names(TidyData)<-gsub("Mag", "Magnitude", names(TidyData))
names(TidyData)<-gsub("^t", "Time", names(TidyData))
names(TidyData)<-gsub("^f", "Frequency", names(TidyData))
names(TidyData)<-gsub("tBody", "TimeBody", names(TidyData))
names(TidyData)<-gsub("-mean()", "Mean", names(TidyData), ignore.case = TRUE)
names(TidyData)<-gsub("-std()", "STD", names(TidyData), ignore.case = TRUE)
names(TidyData)<-gsub("-freq()", "Frequency", names(TidyData), ignore.case = TRUE)
names(TidyData)<-gsub("angle", "Angle", names(TidyData))
names(TidyData)<-gsub("gravity", "Gravity", names(TidyData))

#The fifth step of the assignment is to use the data set
#from step 4 to create a second, independent tidy data set
#with the average of each variable for each activity
#and each subject

FinalData <- TidyData %>%
  group_by(subject, activity) %>%
  summarise_all(funs(mean))
write.table(FinalData, "FinalData.txt", row.name=FALSE)


