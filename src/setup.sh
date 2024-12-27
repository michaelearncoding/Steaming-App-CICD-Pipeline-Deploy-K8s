# Grafana
# http://*********:3000

# Jenkins
# *.***.**.***:8080

# SonarQube
# *.***.**.***:9000


# ARGO CI/CD
# localhost:8080
# https://localhost:8080/applications/argocd/amazon-prime?view=tree&resource=

# Prometheus
# *.***.**.***:9090

# Docker hub
# https://app.docker.com/


brew install azure-cli
brew install kubectl

az --version
kubectl version --client

az login
az aks get-credentials --resource-group <your-resource-group> --name <your-cluster-name>
# i.e. az aks get-credentials --resource-group sidehustle-uwaterloo-full-time-cv --name pipeline-25fulltime

kubectl cluster-info

ping pipeline-25fulltime-dns-t11lthll.hcp.canadacentral.azmk8s.io

kubectl get nodes
kubectl get pods -A
kubectl get  ns

# Namespace : argocd
kubectl create namespace argocd

kubectl apply -n argocd -f https://raw.githubusercontent.com/argoproj/argo-cd/stable/manifests/install.yaml

kubectl get pods -n argocd

# Deploy the Azure Kubernetes Service (AKS) cluster with the file `argocd-server-loadbalancer.yaml`

apply command `kubectl apply -f argocd-server-loadbalancer.yaml`

# Port-forward the Argo CD server to your local machine:
kubectl port-forward svc/argocd-server -n argocd 8080:443


kubectl get secret argocd-initial-admin-secret -n argocd -o jsonpath="{.data.password}" | base64 --decode

# Argo CD
# Accesss to https://localhost:8080
# Username: admin


# Namespace:  prometheus-node-exporter
kubectl create namespace prometheus-node-exporter

brew install helm

helm install prometheus-node-exporter prometheus-community/prometheus-node-exporter --namespace prometheus-node-exporter

helm repo add prometheus-community https://prometheus-community.github.io/helm-charts

helm status prometheus-node-exporter --namespace prometheus-node-exporter

kubectl get pods --namespace prometheus-node-exporter

kubectl get svc argocd-server -n argocd


# Access Prometheus Node Exporter
# Get the Prometheus Node Exporter pod name:
export POD_NAME=$(kubectl get pods --namespace prometheus-node-exporter -l "app.kubernetes.io/name=prometheus-node-exporter,app.kubernetes.io/instance=prometheus-node-exporter" -o jsonpath="{.items[0].metadata.name}")

# Port-forward the Prometheus Node Exporter pod to your local machine:
kubectl port-forward --namespace prometheus-node-exporter $POD_NAME 9100

# Open your web browser and navigate to:
# http://127.0.0.1:9100
