# Goldilocks

# Goldilocks is a utility that can help you identify a starting point for resource requests and limits
https://github.com/FairwindsOps/goldilocks

# Installation
https://goldilocks.docs.fairwinds.com/installation/#installation-2

# To check if everythng has been installed
kubectl get all -n goldilocks

# To label goldilocks namespace
kubectl label ns goldilocks goldilocks.fairwinds.com/enabled=true

# Create service and bind port
kubectl -n goldilocks port-forward svc/goldilocks-dashboard 8080:80

# Go to: http://localhost:8080/namespaces