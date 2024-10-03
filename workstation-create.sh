#!/bin/bash

INSTANCE_ID="i-0725aaafdd028ad5e"          
HOSTED_ZONE_ID="Z08801502JQFVUXR02K9R"     
DOMAIN_NAME="workstation.konkas.tech"      

aws ec2 start-instances --instance-ids $INSTANCE_ID

echo "Waiting for the instance to start..."
aws ec2 wait instance-running --instance-ids $INSTANCE_ID
echo "Instance started."

PUBLIC_IP=$(aws ec2 describe-instances \
    --instance-ids $INSTANCE_ID \
    --query "Reservations[0].Instances[0].PublicIpAddress" \
    --output text)

echo "Updating Route 53 record..."
aws route53 change-resource-record-sets \
    --hosted-zone-id $HOSTED_ZONE_ID \
    --change-batch '{
        "Changes": [{
            "Action": "UPSERT",
            "ResourceRecordSet": {
                "Name": "'$DOMAIN_NAME'",
                "Type": "A",
                "TTL": 60,
                "ResourceRecords": [{
                    "Value": "'$PUBLIC_IP'"
                }]
            }
        }]
    }'

echo "DNS record updated with IP: $PUBLIC_IP"
