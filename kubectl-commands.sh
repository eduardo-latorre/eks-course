# Configure kubectl to use AWS
aws eks --region <region> update-kubeconfig --name <cluster-name>

aws eks --region us-east-1 update-kubeconfig --name eks-swat-cluster

# You can create component from a repo directly
kubectl apply -f https://github.com/kubernetes-sigs/metrics-server/releases/latest/download/components.yaml

# To get the context information that's being used by kubectl
kubectl config current-context
kubectl config get-contexts
kubectl config use-context <context-name>
kubectl config view

# Remove contexts
kubectl config unset contexts.<context-name>

# To check the logs of an object
kubectl get logs <pod-name> 

# It shows CPU and Memory is using
kubectl top pod <pod-name>

# To get all the services accounts sa in all namespaces
kubectl get sa -A

# To describe an specific sa, it's better to use the namespace name 
kubectl describe sa <sa-name> -n <namespace>

# Gets the events from a namspaces
kubectl get events -n <namespace>

# Get into a container
kubectl exec -it <container-name> -- /bin/bash