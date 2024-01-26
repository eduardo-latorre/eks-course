# HPA
# Horizontal Pod Autoscaler

# Kubernetes will create a new Pod is receiving more than the 50% of the traffic
# to balance the traffic, according to CloudWatch metrics

# If it was reached the max number of Pod in the Node, Kubernetes will create 
# another Pod, this is called Cluster Autoscaler (Next lecture)

# For instance, we have a EC2 instance t5.large as a Node:
# - vCPU: 2
# - Memory: 8

# Based on demo files
# And we have in the POD resource
containers:
    -   name:  php-apache
        image: k8s.gcr.io/hpa-example
        resources:
            requests:
            cpu: 500m
            limits:
            cpu: 1000m

# And the HPA definition
targetCPUUtilizationPercentage: 50

# So if it exceed 50% of 500m (250m), it will create a new replica
# What it does it to create a replica, as many as necessary, in the manifest file (deployment)

## DEMO

# Used HPA templates from K8s example
https://kubernetes.io/docs/tasks/run-application/horizontal-pod-autoscale-walkthrough/

# 1.- It's necessary to have metrics installed (It's installed in kube-system)
# - AWS
kubectl apply -f https://github.com/kubernetes-sigs/metrics-server/releases/latest/download/components.yaml
# - Minikube
minikube addons enable metrics-server
# Check whether it's been created:
kubectl get hpa

# 2.- Install the deploy and hpa demo

# 3.- Increase the load
kubectl run -i --tty load-generator --rm --image=busybox:1.28 --restart=Never -- /bin/sh -c "while sleep 0.01; do wget -q -O- http://php-apache; done"
