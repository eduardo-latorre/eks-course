# OIDC refers to OpenID Connect, which is a standard authentication protocol. 
# When you create an Amazon EKS cluster, you have the option to enable OIDC, 
# allowing the cluster to use OIDC for authentication purposes.
# https://docs.aws.amazon.com/eks/latest/userguide/enable-iam-roles-for-service-accounts.html

# Create an IAM OIDC identity provider for your cluster
eksctl utils associate-iam-oidc-provider \
    --region us-east-1 \
    --cluster eks-swat-cluster \
    --approve