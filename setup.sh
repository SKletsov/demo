#!/usr/bin/env bash
IMAGE=723915311050.dkr.ecr.us-east-1.amazonaws.com/go
NS=develop
VERSION=1.2.5
K8S=lab

build() {
   docker  build -t $IMAGE:$VERSION   app-code 
}

push() {
   aws ecr get-login-password --region us-east-1 | docker login --username AWS --password-stdin 723915311050.dkr.ecr.us-east-1.amazonaws.com
   docker push  $IMAGE:$VERSION
}

deploy() {
  helm upgrade --install  app --namespace $NS --create-namespace  ./helm-charts/app  -f ./helm-charts/app/values-lab.yaml --set image.tag=$VERSION
}

get(){
  aws eks  update-kubeconfig --name $K8S   
}



case "$1" in
  build)  shift; build "$@" ;;
  get)  shift; get "$@" ;;
  push)  shift; push "$@" ;;
  deploy)  shift; deploy "$@" ;;
  *) print_help; exit 1
esac
