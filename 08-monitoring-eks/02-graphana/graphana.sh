# Grafana

# It's a open source tool to represent metrics
# It needs prometheus to provide the metrics and represent them

kubectl create namespace grafana

helm repo add grafana https://grafana.github.io/helm-charts

helm repo update

helm install grafana grafana/grafana \
    --namespace grafana \
    --set persistence.storageClassName="gp2" \
    --set persistence.enabled=true \
    --set adminPassword='EKS!sAWSome' \
    --set datasources."datasources\.yaml".apiVersion=1 \
    --set datasources."datasources\.yaml".datasources[0].name=Prometheus \
    --set datasources."datasources\.yaml".datasources[0].type=prometheus \
    --set datasources."datasources\.yaml".datasources[0].url=http://prometheus-server.prometheus.svc.cluster.local \
    --set datasources."datasources\.yaml".datasources[0].access=proxy \
    --set datasources."datasources\.yaml".datasources[0].isDefault=true \
    --set service.type=LoadBalancer

# Wait a little bit for the POD to run
kubectl get all -n grafana

# To get the ELB URL
export ELB=$(kubectl get svc -n grafana grafana -o jsonpath='{.status.loadBalancer.ingress[0].hostname}')
echo "http://$ELB"

# This is my URL, but it can be another
http://a8432d28f8a5747a98e7257cd12285cd-1682630869.us-east-1.elb.amazonaws.com

# Get the password
kubectl get secret --namespace grafana grafana -o jsonpath="{.data.admin-password}" | base64 --decode ; echo

# No in the UI enter user and password
# User: admin
# Password: The one got form secret

# - Select + option in the home page
# - import Dashboard
# - Enter in the ID field: 3119 Then clic Load button (The ID is to download a specific dashboard)
# - Then select the Dashboard, Prometheus and clic Import

# To download a specific Dashboard go to:
# https://grafana.com/grafana/dashboards
