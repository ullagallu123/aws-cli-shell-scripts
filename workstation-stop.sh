#!/bin/bash

INSTANCE_ID="i-0725aaafdd028ad5e"

aws ec2 stop-instances --instance-ids $INSTANCE_ID

echo "Waiting for the instance to stop..."
aws ec2 wait instance-stopped --instance-ids $INSTANCE_ID
echo "Instance stopped."
