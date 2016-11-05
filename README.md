# getting-and-cleaning-data-project
A project in the Coursera Course - Getting and Cleaning Data

# run_analysis.R
1. Downloads the dataset (if it doesn't already exists)
2. Loads the files of activities and features
3. Loads both the training and test datasets and selects only the columns which includes 'mean' or 'standard deviation'
4. Loads the activity and subject data for each dataset, and merges those columns with the dataset
5. Merges the two datasets
6. Columns 'activity' and 'subject' are turned into factors
7. Outputs a tidy dataset (tidy.txt) with mean values for each varible for each subject and activity pair.
