Description of the process followed by the R script:
- Specify the URL and destination file name for the data set
- If the dplyr package is not installed, install it
- Download the specified zip file
- Extract each of the needed files (X_test.txt, y_test.txt, X_train.txt, y_train.txt, subject_test.txt, subject_train.txt, activity_labels.txt, and features.txt)
- Combine the test and training datasets together for both X, y, and subject
- Rename each set of columns using valid R column names
- Select the subject (subject), activity code (y), and all columns from X (X) that contained either "mean" or "std" and put them in a single data frame
- Merge the data using the activity code to display the activity name, rather than code, in the table
- Use dplyr's group function to group the resulting data by subject and activity
- output a file containing a summary of the means of each of the grouped columns

Description of columns in the tidy data file

subject - a numerical code corresponding to the subject (1-30)
activity.name - A phrase describing the activity for which the measurements were taken
The average (mean) for the mean and standard deviation (std) of each of the following. -XYZ indicates that the measurement exists in each of the 3 dimensions (X, Y, and Z).
tBodyAcc-XYZ
tGravityAcc-XYZ
tBodyAccJerk-XYZ
tBodyGyro-XYZ
tBodyGyroJerk-XYZ
tBodyAccMag
tGravityAccMag
tBodyAccJerkMag
tBodyGyroMag
tBodyGyroJerkMag
fBodyAcc-XYZ
fBodyAccJerk-XYZ
fBodyGyro-XYZ
fBodyAccMag
fBodyAccJerkMag
fBodyGyroMag
fBodyGyroJerkMag