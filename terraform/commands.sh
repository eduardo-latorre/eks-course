# To start using Terraform
terraform init

terraform plan

# To create resources
terraform apply

# List the resources
terraform state list

# Delete s specific resource FROM THE STATE file
terraform state rm <name>

# Destroy a reosurce
terraform destroy -target RESOURCE_TYPE.NAME


terraform destroy -target aws_eks_node_group.private-nodes -target aws_eks_cluster.demo
terraform destroy -target aws_eks_cluster.demo