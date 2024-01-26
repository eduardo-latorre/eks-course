# Ingress

# Allows to access http and https requests
# Allows to manage TLS and SSL

# Providers
# Nginx, Haproxy, traefik, and AWS ALB (Application Load Balancer) open source tool
# Ingress Controller... investigate

# ALB
# Supports http, https, health checks
# It works as a POD that talks to the LoadBalancer
# ALB Ingress Controller needs a IAM Role
# Ingress traffic:
# - Instance Moder: ALB to Nodeport to Pods
# - IP Mode: ALB to Pods directly, bypass one hop