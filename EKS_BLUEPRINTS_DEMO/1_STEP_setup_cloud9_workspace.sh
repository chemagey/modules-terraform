#!/bin/bash
#Nombre workspace cloud9 eks-blueprints-for-terraform-workshop intancia t3.medium y 4 horas de timeout
echo " "
echo "STEP 1 Installing kubectl +++++++++++++++++"
sudo curl --silent --location -o /usr/local/bin/kubectl \
	           https://amazon-eks.s3.us-west-2.amazonaws.com/1.21.2/2021-07-05/bin/linux/amd64/kubectl

sudo chmod +x /usr/local/bin/kubectl
echo " "
echo "STEP 2 Installing awscli +++++++++++++++++"
curl "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip" -o "awscliv2.zip"
unzip awscliv2.zip
sudo ./aws/install
echo " "
echo "STEP 3 Installing extra utilities +++++++++++++++++"
sudo yum -y install jq gettext bash-completion moreutils
echo " "
echo "STEP 4 Verify installed packages +++++++++++++++++"
for command in kubectl jq envsubst aws
do
	    which $command &>/dev/null && echo "$command in path" || echo "$command NOT FOUND"
    done
    echo " "
    echo "STEP 5 Enable bash completion +++++++++++++++++"
    kubectl completion bash >>  ~/.bash_completion
    . /etc/profile.d/bash_completion.sh
    . ~/.bash_completion
    echo " "
    echo "STEP 6 Disable cloud9 temporary credentials +++++++++++++++++"
    aws cloud9 update-environment  --environment-id $C9_PID --managed-credentials-action DISABLE
    rm -vf ${HOE}/.aws/credentials
#Rol para intancia cloud0  eks-blueprints-for-terraform-workshop-admin  con rol administrator access
