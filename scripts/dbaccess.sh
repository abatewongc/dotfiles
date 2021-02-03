#!/bin/bash
BASTION_PORT_NUM=$1
LOCAL_PORT_NUM=$2

# bastion host tag flag
FILTER_TAG_KEY=$3
FILTER_TAG_VALUE=$4

REGION=$5

OUTPUT=$(aws ec2 describe-instances --filters Name=tag:"$FILTER_TAG_KEY",Values="$FILTER_TAG_VALUE" Name=instance-state-name,Values=running --query 'Reservations[*].Instances[*].{Instance:InstanceId}' --output text --region "$REGION")
for instance_id_iterator in $OUTPUT
do
    INSTANCE_ID=$instance_id_iterator
    break
done

aws ssm start-session --target "$INSTANCE_ID" --document-name AWS-StartPortForwardingSession --parameters "{\"portNumber\":[\"$BASTION_PORT_NUM\"],\"localPortNumber\":[\"$LOCAL_PORT_NUM\"]}" --region "$REGION"