library(tidyverse)
library(CDLX)

 
####################### 1. Merges the training and the test sets to create one data set.########################


setwd(".")

##### Read in Training Set Data and Clean up column names
subjecttrain<-read.table("./train/subject_train.txt", sep = " ")
names(subjecttrain)<-'subject'
xtrain<-read.table("./train/X_train.txt")
ytrain<-read.table("./train/Y_train.txt", sep = " ")
names(ytrain)<-'activitylabel'


train<-subjecttrain %>% bind_cols(ytrain) %>% mutate(datagroup = 'Train') %>% bind_cols(xtrain) %>% as_tibble

train %>% filter(subject ==1) %>% group_by(activitylabel) %>% summarise(n = n())



##### Read in Test Set Data and Clean up column names 
subjecttest<-read.table("./test/subject_test.txt", sep = " ")
names(subjecttest)<-'subject'
xtest<-read.table("./test/X_test.txt")
ytest<-read.table("./test/Y_test.txt", sep = " ")

names(ytest)<-'activitylabel'

test<-subjecttest %>% bind_cols(ytest) %>% mutate(datagroup = 'Test') %>% bind_cols(xtest) %>% as_tibble


### combine test and training sets

all<-train %>% bind_rows(test)



########################2. Extracts only the measurements on the mean and standard deviation for each measurement.##############

### read in feature names and name variables in main data set

feats<-read.table("./features.txt")

names(all)[4:564]<-feats$V2

###select only measures that are means/std

mean_std<-all %>% select(subject, activitylabel, datagroup, contains("mean()"), contains("std()"))


#################3. Uses descriptive activity names to name the activities in the data set #################


#read in activity labels
act<-read.table("./activity_labels.txt") %>% 
  rename(activitylabel = V1, 
         activityname = V2)

#join activity labels back to dataset
descriptive_data<-mean_std %>% inner_join(act, by = "activitylabel") %>% select(subject, activityname, datagroup, everything(), -activitylabel)




#################4. Appropriately labels the data set with descriptive variable names ################# 


#the data is already descriptively named from feature data set on line 46



########## 5. From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.############

grouped_data <- descriptive_data %>% group_by(subject,activityname) %>% 
  summarise_if(is.double, mean)

grouped_data

###write out final data source

write.table(grouped_data, "./final_data_tidy.txt", row.name =FALSE)

