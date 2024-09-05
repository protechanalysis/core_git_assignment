##!/bin/bash

# Creating json_and_CSV folder
mkdir -p json_and_CSV

# Moving all the csv file into json_and_CSV folder
mv *.csv json_and_CSV/
if [ -f json_and_CSV/*.csv ]; then
    echo "The file has been successfully saved into the folder."
else
    echo "The file could not be saved into the folder. Please check your script."
fi

# Moving all the json file into json_and_CSV folder
mv *.json json_and_CSV/

if [ -f json_and_CSV/*.json ]; then
    echo "The file has been successfully saved into the folder."
else
    echo "The file could not be saved into the folder. Please check your script."
fi