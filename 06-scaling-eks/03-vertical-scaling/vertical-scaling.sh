# Vertical POD Autoscaling (VPA) - non-prod recomemded
# - Creates more size instead of new pod
# - It restarts pods to add mor size
# - Used in dev to determined optimal CPU and Memory (requests and HPA)

# Vertical Pod Autoscaler repo:
# Follow all the steps in the readme to install it
https://github.com/kubernetes/autoscaler/tree/master/vertical-pod-autoscaler

# Create the example hamster ./autoscaler/vertical-pod-autoscaler/examples
kubectl apply -f hamster.yaml

# Check PODs to see how much memory they're using
kubectl top pod hamster-59cc68d575-jld67

# To get the recomendation from vpa
kubectl describe vpa

# This provides all the information about the resources recommended
Recommendation:
    Container Recommendations:
      Container Name:  hamster
      Lower Bound:
        Cpu:     381m
        Memory:  262144k
      Target:
        Cpu:     587m
        Memory:  262144k
      Uncapped Target:
        Cpu:     587m
        Memory:  262144k
      Upper Bound:
        Cpu:     1
        Memory:  500Mi