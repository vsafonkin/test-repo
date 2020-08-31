# Enable-WindowsOptionalFeature -Online -FeatureName Microsoft-Hyper-V-Management-PowerShell
minikube start
minikube status
kubectl create deployment test-minikube --image=k8s.gcr.io/echoserver:1.10
kubectl expose deployment test-minikube --type=NodePort --port=8080
Start-Sleep -Seconds 60
kubectl get pod
minikube service test-minikube --url
