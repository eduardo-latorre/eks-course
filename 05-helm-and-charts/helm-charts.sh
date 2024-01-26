# It's a tool that allow to manage packgesfor K8s
# Helm packages are called charts
# Helm charts allow to define, install and upgrade complex kubernetes apps
# Allows to version, share and publish
# Accepts input parameters 
# Most popular packages al already available
# Hub: https://artifacthub.io/

# Install Helm
brew install helm

# Searches all the local repos
helm search repo

# Search the packages in the hub
helm search hub nginx

# Add repo -> This is just metadata
helm repo add bitnami https://charts.bitnami.com/bitnami

# Pull the repo into local
helm pull bitnami/nginx --version 15.5.3 --untar=true

# Install repo, creates all the k8s objects
helm install my-nginx bitnami/nginx --version 15.5.3

# Uninstall repo, --dry-run option it's for it won't execute
helm uninstall prometheus -n prometheus --dry-run
helm uninstall monitoring
