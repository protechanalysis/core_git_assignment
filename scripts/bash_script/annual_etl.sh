#!/bin/bash

# Create the raw folder if it doesn't exist
mkdir -p raw

# Define the URL for the CSV file
export url="https://www.stats.govt.nz/assets/Uploads/Annual-enterprise-survey/Annual-enterprise-survey-2023-financial-year-provisional/Download-data/annual-enterprise-survey-2023-financial-year-provisional.csv"

# Download the CSV file and save it into the raw folder
curl -o annual-enterprise-survey-2023-financial-year-provisional.csv $url

# Moving the csv file into raw folder
mv annual-enterprise-survey-2023-financial-year-provisional.csv raw/

# Check if the file has been saved successfully
if [ -f raw/annual-enterprise-survey-2023-financial-year-provisional.csv ]; then
    echo "The file has been successfully saved into the raw folder."
else
    echo "The file could not be saved into the raw folder. Please check your script."
fi


echo "Transformation stage starting"

# Create the Transform folder if it doesn't exist
mkdir -p Transformed

# Renaming Variable_code column to variable_code and passing into a new csv file
sed '1s/Variable_code/variable_code/' raw/annual-enterprise-survey-2023-financial-year-provisional.csv > Transformed/annual_2023_rename.csv

# selecting column 1,5,6,9 then passing into a new csv file
cut -d ',' -f1,9,5,6 Transformed/annual_2023_rename.csv > 2023_year_finance.csv

# Moving the csv file into Transformed folder
mv 2023_year_finance.csv Transformed/

# Check if the file has been saved successfully
if [ -f Transformed/2023_year_finance.csv ]; then
    echo "The file has been successfully saved into the Transform folder."
else
    echo "The file could not be saved into Transform folder. Please check your script."
fi


# Create the Transform folder if it doesn't exist
mkdir -p Gold

# Moving the 2023_year_finance.csv from Transformed to Gold folder
mv Transformed/2023_year_finance.csv Gold

# Check if the file has been saved successfully
if [ -f Gold/2023_year_finance.csv ]; then
    echo "The file has been successfully saved into the Gold folder."
else
    echo "The file could not be saved into the Gold folder. Please check your script."
fi