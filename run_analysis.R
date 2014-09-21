# You should create one R script called run_analysis.R 
#that does the following. 
# 1. Merges the training and the test sets to create one data set.
# 2. Extracts only the measurements on the mean and 
#    standard deviation for each measurement. 
# 3. Uses descriptive activity names to 
#    name the activities in the data set
# 4. Appropriately labels the data set with descriptive variable names. 
# 5. From the data set in step 4, creates a second, 
#    independent tidy data set with the average of 
#    each variable for each activity and each subject.

fileUrl <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"

setwd("/Users/Charlene/Desktop/R Code/Getting and Cleaning Data")
path <- getwd()
#----------DOWNLAODING and UNZIP Finished -NO NEED TO EVALUATE AGAIN------------#
# download.file(fileUrl,destfile="./data/ProData.zip",method ="curl")
# unzip("./data/ProData.zip")
library(data.table)
library(reshape2)
#-------------------------- READ THE FILES----------------------#
dtpath <- file.path(path, "UCI HAR Dataset")

sjtrain <- read.table(file.path(dtpath,"train","subject_train.txt"))#Read Subject DataFrame
sjtest <- read.table(file.path(dtpath,"test","subject_test.txt"))#Read Subject DataFrame

xtrain <- read.table(file.path(dtpath,"train","X_train.txt")) #Read Data sets DataFrame
xtest <- read.table(file.path(dtpath,"test","X_test.txt")) #Read Data sets DataFrame

ytrain <- read.table(file.path(dtpath,"train","Y_train.txt")) #Read Labels DataFrame
ytest <- read.table(file.path(dtpath,"test","Y_test.txt")) #Read Labels DataFrame

sjtrain <- data.table(sjtrain) #DataTable
sjtest <- data.table(sjtest) #DataTable

xtrain <- data.table(xtrain) #DataTable
xtest <- data.table(xtest) #DataTable

ytrain <- data.table(ytrain) #DataTable
ytest <- data.table(ytest) #DataTable

#-------------------------1. Merge the training and the test sets ----------------------#
subjectdt <- rbind(sjtrain,sjtest) #merge train and test subjects
labeldt <- rbind(ytrain,ytest) #merge train and test labels
setdt <- rbind(xtrain,xtest) # merger train and test data sets

setnames(subjectdt, "V1", "Subject")
setnames(labeldt,"V1","ActivityLabels")

dtset <- cbind(labeldt,setdt)
dtset <- cbind(subjectdt,dtset)

setkey(dtset,Subject,ActivityLabels) #sort the data.table

#--------------2.Extracts only the measurements on the mean and standard deviation -------#
fetr <- read.table(file.path(dtpath,"features.txt")) # Read in the features
setnames(fetr,"V1","Num")
setnames(fetr,"V2","Feature")

fnum <- fetr[grepl("mean\\(\\)|std\\(\\)", fetr$Feature),] #select MEAN and STD colnames 
sel <-c(1,2,fnum$Num+2) # selcet MEAN and STD colnumbers
dtaft <- dtset[,sel,with=FALSE] # subset dataset to get only MEAN and STD cols

#--------------------3. Uses descriptive activity names-----------------------------#
dtactivityName <- fread(file.path(dtpath,"activity_labels.txt")) # Read in activity names
setnames(dtactivityName,names(dtactivityName),c("ActivityLabels","ActivityName"))

dataAct <- merge(dtaft,dtactivityName,by="ActivityLabels",all.x=TRUE)
setkey(dataAct,Subject,ActivityLabels,ActivityName)

dataAct <- data.table(melt(dataAct,key(dataAct),variable.name="featureLabel")) # reshape data to a tall and narrow format

fetr$featureLabel <- paste0("V",fetr$Num) # establish the link between colname and feature name

dataAct <- merge(dataAct,fetr[,c("Num","Feature","featureLabel")],by="featureLabel",all.x = TRUE) # merge feature name

#--------------------4.Appropriately labels the data set with descriptive variable names-------------#

dataAct$Feature <- gsub("()","",dataAct$Feature,fixed="TRUE") # remove ()
dataAct$Feature <- gsub("^t","Time",dataAct$Feature)# use Time to replace t
dataAct$Feature <- gsub("^f","Frequency",dataAct$Feature)# use Frequency to replace f
dataAct$Feature <- gsub("mean","Mean",dataAct$Feature)# use Mean to replace mean
dataAct$Feature <- gsub("std","STD",dataAct$Feature) # replace std with STD
dataAct$Feature <- gsub("Acc","Accelerometer",dataAct$Feature)# use Accelerometer to replace Acc
dataAct$Feature <- gsub("Gyro","Gyroscope",dataAct$Feature) # use Gyroscope to replace Gyo
dataAct$Feature <- gsub("-","",dataAct$Feature,fixed="TRUE") # remove -
dataAct$Feature <- gsub("Mag","Magnitude",dataAct$Feature,fixed="TRUE") # Repalce Mag with Magnitude
dataAct$Feature <- gsub("BodyBody","Body",dataAct$Feature)# Remove the duplicate Body

#---------------------5. creates tidy data set with the average of each variable for each activity and each subject--------#
setkey(dataAct,Subject,ActivityName,Feature) # set the key for re-arrange
dtTidy <- dataAct[, list(count = .N, average = mean(value)), by = key(dataAct)] # Calculate the average and attached to dtTidy

#---------------WRITE TIDY DATA TO A TEXT file---------------#
write.table(dtTidy, file="TidyData.txt", sep="\t",row.name=FALSE)


