#!/bin/bash
#
if [[ $# -lt 3 ]]; then
  echo "Usage: $0 <database> <table> <column>"
  exit 1
fi

# required arguments
database=$1
table=$2
column=$3

# parse optional arguments
if [[ $# -gt 3 ]]; then
  limit=$4
else
  limit="100"
fi;

# poor man's error logging
echo "SELECT $column FROM $database.$table LIMIT $limit" 1>&2

query_id=$(aws athena start-query-execution \
  --query-string "SELECT $column FROM $database.$table LIMIT $limit" \
  --query-execution-context Database=$database \
  --result-configuration OutputLocation=s3://ss-bi-datalake-query-results \
  --region us-east-1 \
  --output text \
  --query 'QueryExecutionId')

# Wait for the query to finish
while true
do
    echo "Waiting for query $query_id" 1>&2
    EXECUTION_STATUS=$(aws athena get-query-execution --query-execution-id $query_id --output text --query 'QueryExecution.Status.State')
    if [ "$EXECUTION_STATUS" == "SUCCEEDED" ]; then
        break
    elif [ "$EXECUTION_STATUS" == "FAILED" ]; then
        echo "Query execution failed"
        exit 1
    fi
    sleep 5
done

echo "Downloading results for query $query_id" 1>&2
result_location=$(aws athena get-query-execution --region us-east-1 --query-execution-id $query_id --query QueryExecution.ResultConfiguration.OutputLocation --output text)
csv=$(aws s3 cp "$result_location" -)

echo "I will give you $limit rows of data. The data is from a column, $column, in table $table." \
     "Based on this sample, I would like you to guess what the meaning of the column is. I would" \
     "also like you to comment on what the Athena data type of the column might be. Be sure to " \
     "mention any outliers you observe as well." \
     $(echo "$csv")
