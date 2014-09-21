CodeBook for run_analysis.R
===========================
 CodeBook describes the variables, the data, and any transformations that performed to clean up the data
 
 Varibales in dtTidy which used to generate TidyData.txt
-----------------------


| Column Name   |     Description       |
| ------------- |:-------------| 
| Subject      |The ID of Subject that did the activity | 
| ActivityName      |They types of activity the Subject was doing      | 
| Feature | Describe the feature of the activity      |
| count    | The number of data points that the specific Feature counts|
| average  | The average value calcualted for specific Feature based on the "count" data points|

Start from Beginning of the program
-----------------------------------
Read in the following data and put in varibales
----------------------------------------------


| Varibale   |     Description       |
| ------------- |:-------------| 
| sjtrain,sjtest |The training and test set ID of Subject that did the activity respectively | 
| xtrain,xtest |The training and test data set respectively     | 
| ytrain,ytest |The training and test activity respectively    |

Merge the training and the test sets and get data set with varibale: dtset
--------------------------------------------------------------------------

| Column Name   |     Description       |
| ------------- |:-------------| 
| Subject      |The ID of Subject that did the activity | 
| ActivityLabels   |They activity number the Subject was doing      | 

⋅⋅⋅The rest of the columns are like "V1" "V2"... represent the different types of data.

Extracts only the measurements on the mean and standard deviation 
-----------------------------------------------------------------
⋅⋅⋅variable: dtaft

⋅⋅⋅Column properties are like in dtset, but only with column that are mean or standard deviation values

⋅⋅⋅dtaft is in data.table format
⋅⋅⋅nrow X ncol is 10299X68


Uses descriptive activity names
--------------------------------

⋅⋅⋅read in the activity name from "activity_labels.txt".

⋅⋅⋅Assign the activity name according to dtaft$ActivityLabels.
⋅⋅⋅The final variable: dataAct


| Column Name   |     Description       |
| ------------- |:-------------| 
| featureLabel | The column name in "dtset" that coppreponidng to specific data feature eg."V1"|
| Subject      |The ID of Subject that did the activity | 
| ActivityLabels   |They activity number the Subject was doing      | 
| ActivityName  | The name of activity coresponding to the ActivityLabels|
| value |Value of the feature measured for the subject while doing ActivityName| 
|Num|featureLabel number wihout "V", eg."1"|
|Feature| feature name for type of measurement eg. "tBodyAcc-mean()-X"|

4. Appropriately labels the data set with descriptive variable names
⋅⋅* Remove () and -
⋅⋅* Replace 't' and 'f' with 'Time' and 'Frequency' respectively
⋅⋅* Replace 'mean' and 'std' with 'Mean' and 'STD' respectively
⋅⋅* Replace 'Acc','Gyro','Mag' with 'Accelerometer','Gyroscope','Magnitude' respectively
⋅⋅* Remove redundant 'Body' in string containing'BodyBody'

⋅⋅⋅resulting variable :dataAct

5. creates tidy data set with the average of each variable for each activity and each subject
⋅⋅⋅reshaping accoridng to Subject,ActivityName and Feature
⋅⋅⋅Resulting variable: dtTidy
⋅⋅⋅The description is in the beginning of this file.
