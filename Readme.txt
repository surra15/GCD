Run Analysis -- Course Project for Getting and Cleaning Data Coursera Couse
---------------------------------------------------------------------------

The input data for this project is from 
      https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip
      
    Getting the data:
          Get data from the above URL using download.file()
          unzip the file to get the test and training data
          the data of interest is under the train and test directories
          along with the description data in features.txt, README.txt, activity_labels.txt
	--- directory structure ---------------
	UCI HAR Dataset/:
		README.txt
		activity_labels.txt
		features.txt
		features_info.txt
		test/
			Inertial Signals
			X_test.txt
			subject_test.txt
		train/
			Inertial Signals
			X_train.txt
			subject_train.txt
			y_train.txt
	----end directory structure ------------
Description of the data of interest to this analysis:
---------------------------------------------------
	the measurements are in train/ and test/ directories under x_train.txt and x_test.txt
	y_train.txt and y_test.txt: these provide the subject who performed the activity for this specific measurement vector
	subject_train.txt and subject_test.txt: these provide the activity the specific subject performed during that specific measurement
	activity_labels.txt: provides the types of activities performed
	features.txt: provides the types of measurements collected (factors)

Analysis of the data of interest:
-------------------------------

Step1:
	Read all the relevant data into x_train, x_test, y_train, y_test, features, 
          sub_train and sub_test
    Create data sets for train and test while adding new subject and activity columns to the front of the data sets
    combine rowwise both the data sets into data
    
Step 2:
    Now pick up only the measurements that have a mean ore std in them
    These columns are retained in the data set "data" and the rest of the columns are discarded

Step 3:
    Assign the activity names to the activity column by picking these from activity_labels.txt
    Note: Please read comments in run_analysis.R as to how this is done

Step4:
    Now apply ddply to obtain columnwise means for each variable for each activity and each subject

Step 5:
    write the corresponding output from Step 4: to tidy_data.txt
