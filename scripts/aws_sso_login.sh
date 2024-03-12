#!/usr/bin/env bash

aws sts get-caller-identity --output json --no-cli-pager

if [ $? -ne 0 ]; then
  aws sso login
  aws configure export-credentials --profile os-dev --format env-no-export > ~/workspace/tmp/aws.dev.properties
else
  echo "AWS already authenticated"
  aws configure export-credentials --profile os-dev --format env-no-export > ~/workspace/tmp/aws.dev.properties
fi