# ALB Ingress

# The guide to follow:
#https://docs.aws.amazon.com/eks/latest/userguide/aws-load-balancer-controller.html

# Requires
# - Deployment Manifest
# - ALB Ingress Controller (IAM Permissions)
# - Service Manifest (Nodeport)
# - Ingress Resource ALB

# The down bellow policy will allow to create the next steps policies
{
    "Version": "2012-10-17",
    "Statement": [
        {
            "Effect": "Allow",
            "Action": [
                "iam:CreatePolicy",
                "iam:DetachRolePolicy",
                "iam:CreateRole",
                "iam:AttachRolePolicy"
            ],
            "Resource": "*"
        }
    ]
}

curl -O https://raw.githubusercontent.com/kubernetes-sigs/aws-load-balancer-controller/v2.5.4/docs/install/iam_policy.json

aws iam create-policy \
    --policy-name AWSLoadBalancerControllerIAMPolicy \
    --policy-document file://iam_policy.json

# Create the service account and link the created policy
eksctl create iamserviceaccount \
  --cluster eks-swat-cluster \
  --namespace kube-system \
  --name aws-load-balancer-controller \
  --role-name AmazonEKSLoadBalancerControllerRole \
  --attach-policy-arn arn:aws:iam::709650096898:policy/AWSLoadBalancerControllerIAMPolicy \
  --override-existing-serviceaccounts \
  --approve

# The following installs custom resource definitions (CRDs) necessary for the controller to function
kubectl apply -k "github.com/aws/eks-charts/stable/aws-load-balancer-controller/crds?ref=master"

helm repo add eks https://aws.github.io/eks-charts

helm upgrade -i aws-load-balancer-controller eks/aws-load-balancer-controller \
  --namespace kube-system \
  --set clusterName=eks-swat-cluster \
  --set serviceAccount.create=false \
  --set serviceAccount.name=aws-load-balancer-controller 

# Check the status of the deployment creation
kubectl -n kube-system rollout status deployment aws-load-balancer-controller

# Check the pods running
kubectl get deployment -n kube-system aws-load-balancer-controller

##############################
# Components creation to test a DEMO
# - service.yml

# Create namespace:
kubectl create namespace apps

# Create the components:
SERVICE_NAME=first NS=apps envsubst < service.yml | kubectl apply -f -
SERVICE_NAME=second NS=apps envsubst < service.yml | kubectl apply -f -
SERVICE_NAME=third NS=apps envsubst < service.yml | kubectl apply -f -
SERVICE_NAME=fourth NS=apps envsubst < service.yml | kubectl apply -f -
SERVICE_NAME=error NS=apps envsubst < service.yml | kubectl apply -f -

# Check svc and pods
kubectl get pod,svc -n apps

# Launch the ingress
NS=apps envsubst < ingress.yml | kubectl apply -f -

# Check the ingress
kubectl get ingress -n apps

# Store the ingress URL in a env var
export ALB_URL=$(kubectl get -n apps ingress/apps-ingress -o jsonpath='{.status.loadBalancer.ingress[0].hostname}')