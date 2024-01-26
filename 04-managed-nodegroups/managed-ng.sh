# This a AWS feature only

# Every node in AWS is a EC2 instance with and AMI
# In Vanilla K8s cluster, you need to orchestrate a bug-fix or an update

# In EKS AWS does for you:
# - Create new EC2 instances
# - Release new patches
# - Automate deployments with no downtime, orchestration and autoscaling behind scene
# - AWS will automate the process with just one click
# - AWS will create a new Node and remove the old
# - Repects the budget

# UPGRADING
# It can be upgraded by the user interface or by using this command
eksctl upgrade nodegroup --name=<ng-name> --cluster=<cluster-name>

# From the UI first is necessary to upgrade the controlplane
# Then the Nodes, selecting the strategy (Rolling update or Force update[disruption])
