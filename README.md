---
title: "README"
output: html_document
---

## README Course Project 'Getting and Cleaning Data' 

This README contains information on the script ```run_analysis.R```. 

The script contains the following steps:

1) It reads the features, train and test files into tables. Subsequently it merges the train tables to 1 table, by adding the columns. Same for the test tables. Then it merges the train and test tables to 1 table, by adding the rows of both tables. 

2) It selects the variables 'SubjectNr', 'ActivityNr' and all variables containing 'mean' or 'std' from the merged table.

3) It reads activitynames and activitynumbers into a table. And it merges the former merged table (Total_MSD) with this new table by the variable 'ActivityNr' and calls it 'Total_MSD' again.

4) Tidies the names of the variables by inserting the full names for abreviations like 't' (time) and 'f' (frequency). 

5) Groups the variables by 'SubjectNr' and 'ActivityName' and gives the mean for each variable per row. It writes this in a new table called 'TidyData.txt'  
