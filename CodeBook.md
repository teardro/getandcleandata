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
| Varibale   |     Description       |
| ------------- |:-------------| 
| sjtrain,sjtest |The training and test set ID of Subject that did the activity respectively | 
| xtrain,xtest |The training and test data set respectively     | 
| ytrain,ytest |The training and test activity respectively    |

1. Merge the training and the test sets and get data set with varibale: dtset

| Column Name   |     Description       |
| ------------- |:-------------| 
| Subject      |The ID of Subject that did the activity | 
| ActivityLabels   |They activity number the Subject was doing      | 
The rest of the columns are like "V1" "V2"... represent the different types of data.

2. Extracts only the measurements on the mean and standard deviation 
variable: dtaft

Column properties are like in dtset, but only with column that are mean or standard deviation values

dtaft is in data.table format
Part of the date is shown here. nrowXncol is 10299X68
>head(dtaft)
   Subject ActivityLabels        V1           V2          V3         V4          V5
1:       1              1 0.2820216 -0.037696218 -0.13489730 -0.3282802 -0.13715339
2:       1              1 0.2558408 -0.064550029 -0.09518634 -0.2292069  0.01650608
3:       1              1 0.2548672  0.003814723 -0.12365809 -0.2751579  0.01307987
4:       1              1 0.3433705 -0.014446221 -0.16737697 -0.2299235  0.17391077
5:       1              1 0.2762397 -0.029638413 -0.14261631 -0.2265769  0.16428792
6:       1              1 0.2554682  0.021219063 -0.04894943 -0.2245370  0.02231294
           V6       V41        V42         V43        V44        V45        V46
1: -0.1890859 0.9453028 -0.2459414 -0.03216478 -0.9840476 -0.9289281 -0.9325598
2: -0.2603109 0.9411130 -0.2520352 -0.03288345 -0.9839625 -0.9174993 -0.9490782
3: -0.2843713 0.9463639 -0.2642781 -0.02557507 -0.9628101 -0.9561309 -0.9719092
4: -0.2133875 0.9524451 -0.2598379 -0.02613106 -0.9811001 -0.9643989 -0.9643039
5: -0.1225450 0.9471251 -0.2571003 -0.02842261 -0.9769275 -0.9885960 -0.9604447
6: -0.1131962 0.9457488 -0.2547778 -0.02652145 -0.9853150 -0.9801945 -0.9662646


3.Uses descriptive activity names-
read in the activity name from "activity_labels.txt"

Assign the activity name according to dtaft$ActivityLabels.
The final variable: dataAct
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
..* Remove () and -
..* Replace 't' and 'f' with 'Time' and 'Frequency' respectively
..* Replace 'mean' and 'std' with 'Mean' and 'STD' respectively
..* Replace 'Acc','Gyro','Mag' with 'Accelerometer','Gyroscope','Magnitude' respectively
..* Remove redundant 'Body' in string containing'BodyBody'

resulting variable :dataAct

5. creates tidy data set with the average of each variable for each activity and each subject
 reshaping accoridng to Subject,ActivityName and Feature
Resulting variable: dtTidy
The description is in the beginning of this file.
