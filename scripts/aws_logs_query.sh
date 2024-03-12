#!/bin/bash

# Usage: ./aws_logs_query.sh <region> <time> <query>
REGION=$1
START="$2"
QUERY="$3"

START_DATE="$(date -v-"$START" "+%s")"
END_DATE=$(date "+%s")

QUERY_ID=$(aws logs start-query \
 --region "$REGION" \
 --log-group-name /aws/eks/openspace-jpn-prod/containers \
 --start-time "$START_DATE" \
 --end-time "$END_DATE" \
 --query-string "fields @timestamp,log.message | filter log.message like /$QUERY/" | jq -r '.queryId')

aws logs get-query-results --query-id "$QUERY_ID"