# AWS EKS

## Pre-requisites
In order to use `kubectl` and `eksctl` there's going to be needed the following tools installed in the correct order

### 1-Aws Cli 
Install the lastest version of `aws cli` in order to allow `kubectl` and `eksctl` to manage iam user and roles
Follow the instructions here:
https://docs.aws.amazon.com/cli/latest/userguide/getting-started-install.html

### 2-Kubectl
This tool will allow the user to manage the eks cluster if the credentials and roles are set properly. In order to instruct `kubectl` to manage
a specific cluster, it's necessary to add that the cluster context which is explain later.  
Follow the instructions here:
https://kubernetes.io/docs/tasks/tools/

### 3-Eksctl
Once `kubectl` is installed, now you're fine to proceed to install `eksctl`
Follow the instructions here:
https://eksctl.io/installation/

## Terminology
- CIDR: Stands for Classless Inter-Domain Routing. It is a method used to allocate IP addresses and IP routing. In CIDR, IP addresses are represented in a format that combines the network prefix with the host identifier. For example, in the CIDR notation "192.168.1.0/24", the "/24" indicates that the first 24 bits are used to identify the network, leaving 8 bits for addressing hosts within that network.
