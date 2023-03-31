
# Infrastructure Automation with Terraform and Azure

## Prerequisites

Install Terraform: https://learn.hashicorp.com/tutorials/terraform/install-cli

Install Azure CLI: https://docs.microsoft.com/en-us/cli/azure/install-azure-cli

Install Docker: https://docs.docker.com/engine/install/

Install kubectl: https://kubernetes.io/docs/tasks/tools/install-kubectl/

Configure Azure CLI:

```
az login
```

## Structure

I created the the required infrastructure by means of three modules (which are in modules dir) with the name of aks,load_balancer, network. the main terraform file is in the root dir with the name of main.tf

├── main.tf

├── modules

│   ├── aks

│   │   └── main.tf

│   ├── load_balancer

│   │   └── main.tf

│   └── network

│       └── main.tf


There is a Dockerfile and index.html for creating the image. The image has been created and is accessible on Docker Hub (hadimhn00/hello-world-webapp)

├── Dockerfile

├── index.html

There is a charts directory which contains the helm chart.(it is a simple chart which can be modified for more advanced use-cases)


## Deployment

To deploy this project use the following commands on the main dir:

```
terraform init
terraform apply
```

Configure kubectl to use the AKS cluster:

```
az aks get-credentials --resource-group 1-67d15b4a-playground-sandbox --name myAKSCluster

```
 
 
Apply the webapp.yaml manifest which contains the deployment and the service: 
 ```
kubectl apply -f webapp.yaml
```


verify that the pods are running:
```
 kubectl get pods
```

Check the service to obtain the public IP address:

```
kubectl get svc
```

Now you can access the web app by means of the IP.


## Using helm chart

Run the following command to get the kubeconfig.yaml:

```
terraform output -raw kubeconfig > kubeconfig.yaml

```

Set the KUBECONFIG environment variable to point to the kubeconfig.yaml file:

```
export KUBECONFIG=kubeconfig.yaml
```

Add the official Helm repository:

```
helm repo add stable https://charts.helm.sh/stable
helm repo update
```

run the following command to install through helm:
```
helm install my-release charts/my-web-app
```



## Note

If you want to use helm, don't forget to delete the previous deployment and service which you applied by means of webapp.yaml:

 ```
kubectl delete -f webapp.yaml
```

## Author

- [Hadi](hadi.mhn00@gmail.com)

