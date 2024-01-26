# According to the instance type, is the capacity of nodes that there can be spinned up:
https://docs.aws.amazon.com/eks/latest/userguide/eks-outposts-capacity-considerations.html

# For instance:
# t3.micro = 2 nodes max

# To create a cluster using the imperative mode
eksctl create cluster \
    --name my-eks-cluster \
    --version 1.25 \
    --nodegroup-name my-eks-ng \
    --node-type t3.micro \
    --nodes 2

# To get the running cluster
eksctl get cluster

# To get the nodegroup
eksctl get nodegroup --cluster=my-eks-cluster

# To create a cluster from file
eksctl create cluster --config-file=first-cluster.yml

# To delete the cluster
eksctl delete cluster --name=my-eks-cluster