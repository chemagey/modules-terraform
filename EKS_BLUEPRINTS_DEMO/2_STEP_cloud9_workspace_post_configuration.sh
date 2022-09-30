#!/bin/bash
PROJECT_NAME=eks-blueprint
IAM_ROLE_NAME=eks-blueprints-for-terraform-workshop-admin
echo " "
echo "STEP 1 Configuring account id and region variables  +++++++++++++++++"
export ACCOUNT_ID=$(aws sts get-caller-identity --output text --query Account)
export AWS_REGION=$(curl -s 169.254.169.254/latest/dynamic/instance-identity/document | jq -r '.region')
test -n "$AWS_REGION" && echo AWS_REGION is "$AWS_REGION" || echo AWS_REGION is not set

echo " "
echo "STEP 2 add variables to bash profile  +++++++++++++++++"
echo "export ACCOUNT_ID=${ACCOUNT_ID}" | tee -a ~/.bash_profile
echo "export AWS_REGION=${AWS_REGION}" | tee -a ~/.bash_profile
aws configure set default.region ${AWS_REGION}
aws configure get default.region

echo " "
echo "STEP 3 validate role assigned to cloud9 workspace instance  +++++++++++++++++"
aws sts get-caller-identity --query Arn | grep ${IAM_ROLE_NAME} -q && echo "IAM role valid" || echo "IAM role NOT valid"

echo " "
echo "STEP 4 Create working folder for project and change to folder directory +++++++++++++++++"
mkdir  ~/environment/${PROJECT_NAME}
sleep 1
cd ~/environment/${PROJECT_NAME}