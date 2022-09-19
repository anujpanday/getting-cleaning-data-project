# getting-cleaning-data-project

Step 1 -- I create working directory and read in all X_train, Y_train, X_test, Y_test, and subject_train, and subject_test data sets. I added a couple of more descriptive column names 

Step 2 -- I add a column that says wether or not it is a test or train set then use bind_cols to merge X and Y data sets and subject data sets

Step 3 -- I then use bind_rows to put together the training and test sets. I  call this dataset 'all'

Step 4 -- I read in the feature names and set 'all' dataset column names to the feature names read in

Step 5 -- I select only measures that are means and standard deviations for each measurement. I do not include derived means/stds. I only keep the raw lowest level data in order to maintain tidyness. Derived means/stds can be calculated after the fact

Step 6 -- I read in the activity labels and names 

Step 7 -- I use an inner join to merge the activity names onto the main data set, then remove the activity label

Step 8 -- I use group by/summarise to group the main data set by subject and activityname, and then take the mean of all the measurement columns

Step 9 -- I write the final data set to a .txt file
