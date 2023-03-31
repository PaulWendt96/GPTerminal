#!/bin/bash
#
if [[ $# -lt 2 ]]; then
  echo "Usage: $0 <database> <table>"
  exit 1
fi

# required arguments
database=$1
table=$2

# parse optional arguments
if [[ $# -gt 2 ]]; then
  limit=$3
else
  limit="10"
fi;

query_id=$(aws athena start-query-execution \
  --query-string "SELECT * FROM $database.$table LIMIT $limit" \
  --query-execution-context Database=$database \
  --result-configuration OutputLocation=s3://ss-bi-datalake-query-results \
  --region us-east-1 \
  --output text \
  --query 'QueryExecutionId')

# Wait for the query to finish
while true
do
    EXECUTION_STATUS=$(aws athena get-query-execution --query-execution-id $query_id --output text --query 'QueryExecution.Status.State')
    if [ "$EXECUTION_STATUS" == "SUCCEEDED" ]; then
        break
    elif [ "$EXECUTION_STATUS" == "FAILED" ]; then
        echo "Query execution failed"
        exit 1
    fi
    sleep 5
done

result_location=$(aws athena get-query-execution --region us-east-1 --query-execution-id $query_id --query QueryExecution.ResultConfiguration.OutputLocation --output text)
csv=$(aws s3 cp "$result_location" -)

echo "I'd like you to guess what each of the columns in the following CSV represent." \
     "This data comes from a table called '$table'." \
     $(echo "$csv")
