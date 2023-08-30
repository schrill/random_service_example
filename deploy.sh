#!/bin/bash

Help()
{
   echo "This is a deployment script to provission random system locally or on a cloud via terraform"
   echo
   echo "Syntax: scriptTemplate [-h|l|c]"
   echo "options:"
   echo "h     Print this Help."
   echo "l     Local deployment using local docker via compose."
   echo -e "p    Purge Local deployment done using local docker via compose. \n      CAUTION: This will remove all files and configuration in docker"
   echo "m     Local deployment using local docker via minikube."
   echo -e "u    Purge Local deployment done using Helm on the local docker via minikube. \n      CAUTION: This will remove all files and configuration in minikube and in docker"
   echo "c    Cloud deployment"
   echo -e "r    Purge Cloud deployment done using Helm \n"
   echo
}

Check()
{
if which docker && which minikube && which helm; then
    echo "Docker, minikube helm present continue..."
else
    unameOut="$(uname -s)"
    case "${unameOut}" in
        Linux*)     machine=Linux;;
        Darwin*)    machine=Mac;;
        CYGWIN*)    machine=Cygwin;;
        MINGW*)     machine=MinGw;;
        MSYS_NT*)   machine=Git;;
        *)          machine="UNKNOWN:${unameOut}"
    esac
    echo "Please google how to install, docker, minikube and helm on your system: ${machine}"
    exit 1
fi
}

removecontainers() {
    docker stop $(docker ps -aq)
    docker rm $(docker ps -aq)
}

armaggedon() {
    removecontainers
    docker network prune -f
    docker rmi -f $(docker images --filter dangling=true -qa)
    docker volume rm $(docker volume ls --filter dangling=true -q)
    docker rmi -f $(docker images -qa)
}

Local-compose()
{
Check
docker-compose -f services/local-compose.yml up -d
}

Purge-Local-compose()
{
docker-compose -f services/local-compose.yml down
armaggedon
}

Local-minikube()
{
Check
minikube --driver=docker start
eval $(minikube docker-env)
Cloud
}

Purge-Local-minikube()
{
minikube delete --all --purge
armaggedon
}

Cloud()
{
Check
helm repo add bitnami https://charts.bitnami.com/bitnami
helm repo update
helm install redis bitnami/redis --set service.port=6379 --set auth.enabled=false
SERVICE_PATHS=(services/random-*)
SERVICE_PORTS=(3003, 80, 3002, 3001)
for SERVICE_PATH in "${!SERVICE_PATHS[@]}"; do
    cd ${SERVICE_PATHS[$SERVICE_PATH]}
    IMAGE_NAME=`echo ${SERVICE_PATHS[$SERVICE_PATH]} | cut -d/ -f2`
    docker build -t $IMAGE_NAME -f ./Dockerfile .;
    helm install $IMAGE_NAME ./helm/ --set service.port=${SERVICE_PORTS[$SERVICE_PATH]}
    cd ../../
done
}

Purge-Local-cloud()
{
helm uninstall redis
SERVICE_PATHS=(services/random-*)
for SERVICE_PATH in "${!SERVICE_PATHS[@]}"; do
    cd ${SERVICE_PATHS[$SERVICE_PATH]}
    IMAGE_NAME=`echo ${SERVICE_PATHS[$SERVICE_PATH]} | cut -d/ -f2`
    helm uninstall $IMAGE_NAME
    cd ../../
done
}

while getopts ":hlmcpur" option; do
   case $option in
      h) Help
         exit;;
      l)  Local-compose;;
      m)  Local-minikube;;
      p)  Purge-Local-compose;;
      u)  Purge-Local-minikube;;
      r)  Purge-Local-cloud;;
      c)  Cloud;;
     \?)echo "Error: Invalid option, use -h to see available options"
         exit;;
   esac
done
