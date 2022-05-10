### GoLang Hello Apps 


## Helm 

Parametrs 

| key              	| descriptions     	| ovveride 	| example 	|
|------------------	|------------------	|----------	|---------	|
| replicaCount     	| num of replica   	| true     	| 1       	|
| image.repository 	| repo in ecr      	| true     	|         	|
| image.tag        	| tag docker image 	| true     	| 1.21.1  	|



## Terraform

This project , consist this components 

* S3
* EKS
* NLB
* SG
* VPC
* ECR 

### Deploy 

```bash 
configure AWS Profile via aws-cli
install terraform close 1.0.1 
go to tf dir 
cd terraform
terraform init
terraform plan 
terraform apply 

```
## Apps

### List of Request 
This apps wrote by GoLang and have any sample request like 

```bash
8080:/
8080/ping
8080:/health
```
* /ping - return PONG in HTML format, status code 200 OK  
* / - return current weather in Moscow, Russia in HTML format
* /health - return status code 200, in JSON format  

## Build 

We can build this Apps used ,Dockerfile , which have 2 stages

* Buld Stage 
* Run Stage 

