# install docker
sudo apt-get update

sudo apt-get install -y \
    ca-certificates \
    curl \
    gnupg \
    lsb-release

curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --dearmor -o /usr/share/keyrings/docker-archive-keyring.gpg

echo \
  "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/docker-archive-keyring.gpg] https://download.docker.com/linux/ubuntu \
  $(lsb_release -cs) stable" | sudo tee /etc/apt/sources.list.d/docker.list > /dev/null

sudo apt-get update
sudo apt-get install docker-ce docker-ce-cli containerd.io -y

sudo usermod -aG docker $USER

# after this run an vagrant reload

RES_GROUP=microproyecto-2
RES_LOCATION=australiaeast
ACR_NAME=zeroacrng
CLUSTER_NAME=clusterCN

# install azure cli

sudo apt-get update
sudo apt-get install ca-certificates curl apt-transport-https lsb-release gnupg -y 

curl -sL https://packages.microsoft.com/keys/microsoft.asc |
    gpg --dearmor |
    sudo tee /etc/apt/trusted.gpg.d/microsoft.gpg > /dev/null

AZ_REPO=$(lsb_release -cs)
echo "deb [arch=amd64] https://packages.microsoft.com/repos/azure-cli/ $AZ_REPO main" |
    sudo tee /etc/apt/sources.list.d/azure-cli.list

sudo apt-get update
sudo apt-get install azure-cli


# login in azure
az login

# Create resource group|
az group create --name $RES_GROUP --location $RES_LOCATION

#create container registry
az acr create -g $RES_GROUP --name $ACR_NAME --sku Basic

# create cluster aks
az aks create -g $RES_GROUP --name $CLUSTER_NAME --node-count 2 --enable-addons monitoring --generate-ssh-keys --attach-acr  $ACR_NAME

# intall kubectl
sudo az aks install-cli

# Login to container registry
az acr login --name $ACR_NAME

cd /vagrant/app
az acr build --image kubermatic-dl:v1 --registry $ACR_NAME --file Dockerfile .

# obtener credenciales al kubectl
az aks get-credentials --resource-group $RES_GROUP --name $CLUSTER_NAME

# listar nodos
kubectl get nodes

# Desplegar app
kubectl apply -f deployment.yaml 

# listar pods
kubectl get pods

# listar deployments
kubectl get deployments --all-namespaces=true

# exponer app
kubectl expose deployment kubermatic-dl-deployment  --type=LoadBalancer --port 80 --target-port 5000

#obtener servicios
kubectl get service

#conexion
curl -X POST -F img=@horse-galloping-in-grass.jpg http://20.92.157.131/predict



# voting app
kubectl apply -f app-vote.yaml
kubectl get pods
kubectl get service azure-vote-front --watch


# HPA
# autoscale
kubectl apply -f https://k8s.io/examples/application/php-apache.yaml

kubectl run -i \
    --tty load-generator \
    --rm --image=busybox \
    --restart=Never \
    -- /bin/sh -c "while sleep 0.01; do wget -q -O- http://php-apache; done"

kubectl get hpa php-apache
