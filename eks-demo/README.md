# This is for 3 tier application infrastructure
# Verify if kubelet and kube-proxy running
ps -ef | grep kube

# Verify kubelet-config.json
cat /etc/kubernetes/kubelet/kubelet-config.json

# Verify kubelet kubeconfig
cat /var/lib/kubelet/kubeconfig

# Verify clusters.cluster.server value(EKS Cluster API Server Endpoint)  DNS resolution which is taken from kubeconfig
nslookup <EKS Cluster API Server Endpoint>
Very Important Note: Test this on Bastion Host, as EKS worker nodes doesnt have nslookup tool installed. 
[or]
# Verify clusters.cluster.server value(EKS Cluster API Server Endpoint)   with wget 
Try with wget on Node Group EC2 Instances (both public and private)
wget <Kubernetes API Server Endpoint>

## Steps to Verify Namespaces and Resources in Namespaces
```t
# Verify Namespaces
kubectl get namespaces
kubectl get ns 
Observation: 4 namespaces will be listed by default
1. kube-node-lease
2. kube-public
3. default
4. kube-system

# Verify Resources in kube-node-lease namespace
kubectl get all -n kube-node-lease

# Verify Resources in kube-public namespace
kubectl get all -n kube-public

# Verify Resources in default namespace
kubectl get all -n default
Observation: 
1. Kubernetes Service: Cluster IP Service for Kubernetes Endpoint

# Verify Resources in kube-system namespace
kubectl get all -n kube-system
Observation: 
1. Kubernetes Deployment: coredns
2. Kubernetes DaemonSet: aws-node, kube-proxy
3. Kubernetes Service: kube-dns
4. Kubernetes Pods: coredns, aws-node, kube-proxy
```

## Step to Verify pods in kube-system namespace
```t
# Verify System pods in kube-system namespace
kubectl get pods # Nothing in default namespace
kubectl get pods -n kube-system
kubectl get pods -n kube-system -o wide

# Verify Daemon Sets in kube-system namespace
kubectl get ds -n kube-system
Observation: The below two daemonsets will be running
1. aws-node
2. kube-proxy

# Describe aws-node Daemon Set
kubectl describe ds aws-node -n kube-system
Observation: 
1. Reference "Image" value it will be the ECR Registry URL 

# Describe kube-proxy Daemon Set
kubectl describe ds kube-proxy -n kube-system
1. Reference "Image" value it will be the ECR Registry URL 

# Describe coredns Deployment
kubectl describe deploy coredns -n kube-system
```