# Prometheus

# Monitors the EKS cluster
# Create alerts
# Opensource tool
# Runs on a Deamon as a POD in the prometheus namespace

# Installation

# Install Kubernertes Metrics Server
# https://docs.aws.amazon.com/eks/latest/userguide/metrics-server.html
kubectl apply -f https://github.com/kubernetes-sigs/metrics-server/releases/latest/download/components.yaml
kubectl get deployment metrics-server -n kube-system

# Before installing prometheus, we need to create a PVC, Persisten Volume Claim and 
# attach a policy to be able to write, delete, create, and so forth.
# Font: https://stackoverflow.com/questions/75758115/persistentvolumeclaim-is-stuck-waiting-for-a-volume-to-be-created-either-by-ex
eksctl create iamserviceaccount \
    --region us-east-1 \
    --name ebs-csi-controller-sa \
    --namespace kube-system \
    --cluster eks-swat-cluster \
    --attach-policy-arn arn:aws:iam::aws:policy/service-role/AmazonEBSCSIDriverPolicy \
    --approve \
    --role-only \
    --role-name AmazonEKS_EBS_CSI_DriverRole

eksctl create addon \
    --name aws-ebs-csi-driver \
    --cluster eks-swat-cluster \
    --service-account-role-arn arn:aws:iam::$(aws sts get-caller-identity --query Account --output text):role/AmazonEKS_EBS_CSI_DriverRole \
    --force

# Installing Prometheus using Helm
kubectl create namespace prometheus
helm repo add prometheus-community https://prometheus-community.github.io/helm-charts
helm upgrade -i prometheus prometheus-community/prometheus \
    --namespace prometheus \
    --set alertmanager.persistentVolume.storageClass="gp2",server.persistentVolume.storageClass="gp2"
kubectl get pods -n prometheus
kubectl --namespace=prometheus port-forward deploy/prometheus-server 9090

# In case there're some issues
kubectl get events -n prometheus

# In the UI search to get some info
# container_memory_usage_bytes