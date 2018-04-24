This is the code book for Getting and Cleaning Data Course Project
------------------------------------------------------------------
Data Set Information:
--------------------
The experiments have been carried out with a group of 30 volunteers within an age bracket of 19-48 years. Each person performed six activities (WALKING, WALKING_UPSTAIRS, WALKING_DOWNSTAIRS, SITTING, STANDING, LAYING) wearing a smartphone (Samsung Galaxy S II) on the waist. Using its embedded accelerometer and gyroscope, we captured 3-axial linear acceleration and 3-axial angular velocity at a constant rate of 50Hz. The experiments have been video-recorded to label the data manually. The obtained dataset has been randomly partitioned into two sets, where 70% of the volunteers was selected for generating the training data and 30% the test data.

The sensor signals (accelerometer and gyroscope) were pre-processed by applying noise filters and then sampled in fixed-width sliding windows of 2.56 sec and 50% overlap (128 readings/window). The sensor acceleration signal, which has gravitational and body motion components, was separated using a Butterworth low-pass filter into body acceleration and gravity. The gravitational force is assumed to have only low frequency components, therefore a filter with 0.3 Hz cutoff frequency was used. From each window, a vector of features was obtained by calculating variables from the time and frequency domain.

For each record it is provided:
Triaxial acceleration from the accelerometer (total acceleration) and the estimated body acceleration.
Triaxial Angular velocity from the gyroscope.
A 561-feature vector with time and frequency domain variables.
Its activity label.
An identifier of the subject who carried out the experiment.
The dataset includes the following files:
'README.txt'

'features_info.txt': Shows information about the variables used on the feature vector.

'features.txt': List of all features.

'activity_labels.txt': Links the class labels with their activity name.

'train/X_train.txt': Training set.

'train/y_train.txt': Training labels.

'test/X_test.txt': Test set.

'test/y_test.txt': Test labels.

The following files are available for the train and test data. Their descriptions are equivalent.

'train/subject_train.txt': Each row identifies the subject who performed the activity for each window sample. Its range is from 1 to 30.

'train/Inertial Signals/total_acc_x_train.txt': The acceleration signal from the smartphone accelerometer X axis in standard gravity units 'g'. Every row shows a 128 element vector. The same description applies for the 'total_acc_x_train.txt' and 'total_acc_z_train.txt' files for the Y and Z axis.

'train/Inertial Signals/body_acc_x_train.txt': The body acceleration signal obtained by subtracting the gravity from the total acceleration.

'train/Inertial Signals/body_gyro_x_train.txt': The angular velocity vector measured by the gyroscope for each window sample. The units are radians/second.

Notes:
-----
- Features are normalized and bounded within [-1,1].
- Each feature vector is a row on the text file.

Tidy Data:
----------
The resultant dataset is contained in the file "tidyData.txt"

The column names after being provided with descriptive names.

 [1] "activityId"                                                    
 [2] "subjectId"                                                     
 [3] "timeDomainBodyAccelerometerMagnitudeMean"                      
 [4] "timeDomainBodyAccelerometerMagnitudeStandardDeviation"         
 [5] "timeDomainGravityAccelerometerMagnitudeMean"                   
 [6] "timeDomainGravityAccelerometerMagnitudeStandardDeviation"      
 [7] "timeDomainBodyAccelerometerJerkMagnitudeMean"                  
 [8] "timeDomainBodyAccelerometerJerkMagnitudeStandardDeviation"     
 [9] "timeDomainBodyGyroscopeMagnitudeMean"                          
[10] "timeDomainBodyGyroscopeMagnitudeStandardDeviation"             
[11] "timeDomainBodyGyroscopeJerkMagnitudeMean"                      
[12] "timeDomainBodyGyroscopeJerkMagnitudeStandardDeviation"         
[13] "frequencyDomainBodyAccelerometerMagnitudeMean"                 
[14] "frequencyDomainBodyAccelerometerMagnitudeStandardDeviation"    
[15] "frequencyDomainBodyAccelerometerJerkMagnitudeMean"             
[16] "frequencyDomainBodyAccelerometerJerkMagnitudeStandardDeviation"
[17] "frequencyDomainBodyGyroscopeMagnitudeMean"                     
[18] "frequencyDomainBodyGyroscopeMagnitudeStandardDeviation"        
[19] "frequencyDomainBodyGyroscopeJerkMagnitudeMean"                 
[20] "frequencyDomainBodyGyroscopeJerkMagnitudeStandardDeviation"    
[21] "activityType"

Transformations:
---------------
- The data has been transformed in the below ways:
- The training and test sets were merged to create one data set.
- Only measurements containing mean and std were collected.
- Activity identifiers replaced with descriptive names.
- Incoherent variable names and special characters have been dealt with as below:
- Special characters (, and -) were removed
- f and t were expanded to frequencyDomain and timeDomain.
- Acc, Gyro, Mag, Freq, mean, and std were replaced with Accelerometer,
  Gyroscope, Magnitude, Frequency, Mean, and StandardDeviation respectively.
  Replaced BodyBody with Body.
- The code to reproduce the results can be found in run_analysis.R
