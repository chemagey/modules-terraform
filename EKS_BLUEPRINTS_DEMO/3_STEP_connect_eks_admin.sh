#!/bin/bash
REGION=us-east-1
echo "++++++++++++++   Unset variables in the cloud 9 environment"
echo " "
#You can login the cluster as admin using the following command
#aws eks --region ${REGION}  update-kubeconfig --name eks-blueprint
echo "++++++++++++++  Assuming admin role in the cluster and checking if we can see the nodes"
echo " "
PLATFORM_ROLE_ARN=$(terraform output -json | jq '.platform_team.value[]' -r)
echo "PLATFORM_ROLE_ARN is $PLATFORM_ROLE_ARN"
CREDENTIALS=$(aws sts assume-role --role-arn $PLATFORM_ROLE_ARN --role-session-name eks)
export AWS_ACCESS_KEY_ID="$(echo ${CREDENTIALS} | jq -r '.Credentials.AccessKeyId')"
export AWS_SECRET_ACCESS_KEY="$(echo ${CREDENTIALS} | jq -r '.Credentials.SecretAccessKey')"
export AWS_SESSION_TOKEN="$(echo ${CREDENTIALS} | jq -r '.Credentials.SessionToken')"
export AWS_EXPIRATION=$(echo ${CREDENTIALS} | jq -r '.Credentials.Expiration')
aws sts get-caller-identity
kubectl get nodes