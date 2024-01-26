### ###
# AWS CLI (Linux) - Latest version needed
https://docs.aws.amazon.com/cli/latest/userguide/getting-started-install.html

# KUBECTL
# Kubectl works for local and the cloud

# Install the AWS Kubectl version
# https://docs.aws.amazon.com/eks/latest/userguide/install-kubectl.html

# Linux centos
curl -LO "https://dl.k8s.io/release/$(curl -L -s https://dl.k8s.io/release/stable.txt)/bin/linux/amd64/kubectl"


kubectl version --client

### ###
# EKSCTL
# Makes a lot easier to create a cluster because it abstracts different stuff
# Needs to be installed after kubectl
# It will create a cluster with default ec2 instaces that are charged, DONT RUN IT!
eksctl create cluster

# Specifying version an type of nodes 
eksctl create cluster \
    --name <name> \
    --version 1.15 \
    --node-type t3.micro \
    --nodes 2

# Using node group
eksctl create cluster \
    --name <name> \
    --version 1.15 \
    --nodegroup-name <nodegroup-name> \
    --node-type t3.micro \
    --nodes 2 \
    --managed

# Creating a fargate cluster
eksctl create cluster
    --name <name> \
    --fargate

# Also eksctl has different functions like: 
# - Creating, deleting clusters
# - Configuring VPC
# - Managing Policies
# - Write kubeconfig file
# - And so many others