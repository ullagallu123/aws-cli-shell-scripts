#!/bin/bash

sudo yum install -y yum-utils
sudo yum-config-manager --add-repo https://rpm.releases.hashicorp.com/AmazonLinux/hashicorp.repo
sudo yum -y install terraform


if terraform --version &> /dev/null; then
  echo "Terraform installed successfully."
else
  echo "Terraform installation failed!" >&2
  exit 1
fi

echo "alias t='terraform'" >> ~/.bash_profile
echo "alias ti='terraform init'" >> ~/.bash_profile
echo "alias tf='terraform fmt'" >> ~/.bash_profile
echo "alias tv='terraform validate'" >> ~/.bash_profile
echo "alias tp='terraform plan'" >> ~/.bash_profile
echo "alias ta='terraform apply -auto-approve'" >> ~/.bash_profile
echo "alias td='terraform destroy -auto-approve'" >> ~/.bash_profile

echo "Reloading the ~/.bash_profile"
source ~/.bash_profile

if ! command -v python3 &> /dev/null; then
  sudo yum -y install python3
fi

if ! command -v pip3 &> /dev/null; then
  sudo yum -y install python3-pip
fi

pip3 install ansible

if ansible --version &> /dev/null; then
  echo "Ansible installed successfully."
else
  echo "Ansible installation failed!" >&2
  exit 1
fi
