## Getting_Data_Project
### The purpose of this project is to demonstrate your ability to collect, work with, and clean a data set. The goal is to prepare tidy data that can be used for later analysis.

Run_analysis.R cleans up the data:

* Merges the training and test sets to create one data set, (train/X_train.txt with test/X_test.txt).
* Reads features.txt and extracts only the measurements on the mean and standard deviation for each measurement.
* Reads activity_labels.txt and applies descriptive activity names to name the activities in the data set:

walking

walkingupstairs

walkingdownstairs

sitting

standing

laying

* The script also appropriately labels the data set with descriptive names: all feature names (attributes) and activity names are converted to lower case, underscores and brackets () are removed. 
* Then it merges the data frame containing features with  data frames containing activity labels and subject IDs. The result is saved as merged_clean_data.txt, a data frame where the first column contains subject IDs, the second column activity names, and the remaining 66 columns are measurements. Subject IDs are integers between 1 and 30. 
* Finally, the script creates a 2nd, independent tidy data set with the average of each measurement for each activity and each subject. The result is saved as Step 5 - tidy data with averages.txt, where the first column contains subject IDs, the second column contains activity names, and then the averages for each of the 66 attributes are in columns 3 to 68. 
