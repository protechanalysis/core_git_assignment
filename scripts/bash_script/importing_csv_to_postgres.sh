#!/bin/bash

# Variables
DB_NAME="posey" 
DB_USER="postgres"
DB_HOST="localhost"
DB_PORT="5432"

# Prompt for the database password securely
echo "Please enter the database password:"

# Avoiding passing database password for each iteration of the csv file
read -s DB_PASS

# Create the PostgreSQL database if it doesn't exist
PGPASSWORD=$DB_PASS psql -U $DB_USER -h $DB_HOST -p $DB_PORT -c "CREATE DATABASE $DB_NAME;"

# Iterate over CSV files in the directory
for csv_file in *.csv
do
  # Extract the base name of the CSV file excluding directory and extension
  table_name=$(basename "$csv_file" .csv)
  
  # Create a table in the PostgreSQL database assuming the CSV has a header row
  header=$(head -n 1 "$csv_file")
  IFS=',' read -ra columns <<< "$header"
  create_table_sql="CREATE TABLE IF NOT EXISTS $table_name ("

  for column in "${columns[@]}"; do
    create_table_sql+="$column TEXT,"
  done

  # Remove the trailing comma and close the statement
  create_table_sql="${create_table_sql%,}"
  create_table_sql+=");"

  # Execute the SQL command to create the table
  PGPASSWORD=$DB_PASS psql -U $DB_USER -h $DB_HOST -p $DB_PORT -d $DB_NAME -c "$create_table_sql"

  # Copy the CSV data into the table
  PGPASSWORD=$DB_PASS psql -U $DB_USER -h $DB_HOST -p $DB_PORT -d $DB_NAME -c "\copy $table_name FROM '$csv_file' WITH CSV HEADER"

  echo "CSV files have been successfully imported into the PostgreSQL database."

done


