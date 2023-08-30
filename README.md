## Mono repo for example random system

### Included in this repository, are 3 microservice random example applications writen in python as well as the means to locally develop them and deploy them on a EC2 instance running kubernates.

### File structure
    .
    ├── deploy.sh                                 - main deployment helper
    ├── infra                                     - AWS infrastructure resource deployment structure
    ├── REDME.md
    └── services
        ├── local-compose.yml                     - Local compose file to deploy the services
        ├── random-content                        - Random content service accessible through localhost on port 3003 or from egress at http://localhost/content 
        │   ├── app.py
        │   ├── Dockerfile
        │   ├── helm
        │   │   ├── charts
        │   │   ├── Chart.yaml
        │   │   ├── templates
        │   │   │   ├── deployment.yaml
        │   │   │   ├── _helpers.tpl
        │   │   │   ├── hpa.yaml
        │   │   │   ├── ingress.yaml
        │   │   │   ├── NOTES.txt
        │   │   │   ├── serviceaccount.yaml
        │   │   │   ├── service.yaml
        │   │   │   └── tests
        │   │   │       └── test-connection.yaml
        │   │   └── values.yaml
        │   └── requirements.txt
        ├── random-egress                         - Random egress service running nginx accessible at http://localhost/
        │   ├── Dockerfile
        │   ├── helm
        │   │   ├── charts
        │   │   ├── Chart.yaml
        │   │   ├── templates
        │   │   │   ├── deployment.yaml
        │   │   │   ├── _helpers.tpl
        │   │   │   ├── hpa.yaml
        │   │   │   ├── ingress.yaml
        │   │   │   ├── NOTES.txt
        │   │   │   ├── serviceaccount.yaml
        │   │   │   ├── service.yaml
        │   │   │   └── tests
        │   │   │       └── test-connection.yaml
        │   │   └── values.yaml
        │   └── nginx.conf
        ├── random-name                           - Random name service accessible through localhost on port 3002 or from egress at http://localhost/name
        │   ├── app.py
        │   ├── Dockerfile
        │   ├── helm
        │   │   ├── charts
        │   │   ├── Chart.yaml
        │   │   ├── templates
        │   │   │   ├── deployment.yaml
        │   │   │   ├── _helpers.tpl
        │   │   │   ├── hpa.yaml
        │   │   │   ├── ingress.yaml
        │   │   │   ├── NOTES.txt
        │   │   │   ├── serviceaccount.yaml
        │   │   │   ├── service.yaml
        │   │   │   └── tests
        │   │   │       └── test-connection.yaml
        │   │   └── values.yaml
        │   └── requirements.txt                           - Random name service accessible through localhost on port 3002 or from egress at http://localhost/name
        └── random-number                                  - Random number service accessible through localhost on port 3001 or from egress at http://localhost/number
            ├── app.py
            ├── Dockerfile
            ├── helm
            │   ├── charts
            │   ├── Chart.yaml
            │   ├── templates
            │   │   ├── deployment.yaml
            │   │   ├── _helpers.tpl
            │   │   ├── hpa.yaml
            │   │   ├── ingress.yaml
            │   │   ├── NOTES.txt
            │   │   ├── serviceaccount.yaml
            │   │   ├── service.yaml
            │   │   └── tests
            │   │       └── test-connection.yaml
            │   └── values.yaml
            └── requirements.txt

#### Deployment is done through the deploy.sh bash helper, please use -h for more details

#### Should you like to acccess services deployed on kubernates or minikube by selecting -m or -c,
###3 please enable forwarding on the kluster by issuing:
```kubectl port-forward `kubectl get pods | grep <part_od_service_name> | awk {'print $1'}` <local_port>:<container_port>```

#### For infrastructure deployment of AWS resources terraform with terragrunt are used, 
#### so please make sue you have them both installed on your system, 
#### also a valid AWS account cli access should be already preconfigured
#### To deploy the resources, navigate to infra/tg and issue:
```terragrunt run-all apply```
#### This will create a proper VPC structure as well as deploy a EC2 instance on which you'll have everything deployed
#### ssh access to the instance is done securely with SSM by issuing:
```mssh <instance_id>```
#### so please make sure you've installed mssh from AWS
