# Installing Fluentbit as DaemonSet to send logs to CloudWatch
# https://docs.aws.amazon.com/AmazonCloudWatch/latest/monitoring/Container-Insights-setup-logs-FluentBit.html#Container-Insights-FluentBit-setup

kubectl apply -f https://raw.githubusercontent.com/aws-samples/amazon-cloudwatch-container-insights/latest/k8s-deployment-manifest-templates/deployment-mode/daemonset/container-insights-monitoring/cloudwatch-namespace.yaml

# Apply this ConfigMap
ClusterName=eks-swat-cluster
RegionName=us-east-1
FluentBitHttpPort='2020'
FluentBitReadFromHead='Off'
[[ ${FluentBitReadFromHead} = 'On' ]] && FluentBitReadFromTail='Off'|| FluentBitReadFromTail='On'
[[ -z ${FluentBitHttpPort} ]] && FluentBitHttpServer='Off' || FluentBitHttpServer='On'
kubectl create configmap fluent-bit-cluster-info \
--from-literal=cluster.name=${ClusterName} \
--from-literal=http.server=${FluentBitHttpServer} \
--from-literal=http.port=${FluentBitHttpPort} \
--from-literal=read.head=${FluentBitReadFromHead} \
--from-literal=read.tail=${FluentBitReadFromTail} \
--from-literal=logs.region=${RegionName} -n amazon-cloudwatch

# Create DeamonSet
# As a DaemonSet it'll create one Pod per Node
kubectl apply -f https://raw.githubusercontent.com/aws-samples/amazon-cloudwatch-container-insights/latest/k8s-deployment-manifest-templates/deployment-mode/daemonset/container-insights-monitoring/fluent-bit/fluent-bit.yaml

# Get the DaemonSet under amazon-cloudwatch namespace
kubectl get pods -n amazon-cloudwatch

# Check the pod log to determined if there're no issues in creating the cloudwatch
kubectl logs <pod-fluenbit-name> -n amazon-cloudwatch

 ## ISSUE
 # CreateLogStream API responded with error='AccessDeniedException'
 # This is because it's needed a POD IAM Role to grant Fluenbit Container to write in CloudWatch

# To Fix it
kubectl get sa -n amazon-cloudwatch
kubectl describe sa fluent-bit -n amazon-cloudwatch # You'll see no permissions

# To create the permissions
eksctl utils associate-iam-oidc-provider \
    --region us-east-1 \
    --cluster eks-swat-cluster \
    --approve

eksctl create iamserviceaccount \
    --cluster eks-swat-cluster \
    --namespace amazon-cloudwatch \
    --name fluent-bit \
    --attach-policy-arn arn:aws:iam::aws:policy/service-role/AmazonEBSCSIDriverPolicy \
    --override-existing-serviceaccounts \
    --approve
# You can check the new role in AWS IAM, with the suffix eksctl-...iamserviceaccount-Role...

# The error will persist since the POD IAM Role is only read once the DeamonSet is created
# So it's needed to delete the fluenbit pods and the replicaset will create others
kubectl delete pod <fluenbit-pod-name> -n amazon-cloudwatch

# Now check the DaemonSets logs to very

# Now you can check the logs here, following the example in swat cluster
/aws/containerinsights/eks-swat-cluster/application
