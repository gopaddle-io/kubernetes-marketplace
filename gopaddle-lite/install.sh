#!/bin/bash

helm repo add gopaddle-lite https://gopaddle-io.github.io/gopaddle-lite

helm repo update

kubectl create namespace gp-lite

helm install gp-rabbitmq-4-2 gp-lite/gp-lite  --namespace gp-lite  --set global.routingType=NodePortWithOutIngress --set global.installType=public --set global.gp-rabbitmq.enabled=true --set global.gp-lite-core.enabled=false  --version 4.2.2

sleep 1m

helm install gp-core-4-2 gp-lite/gp-lite  --namespace gp-lite  --set global.routingType=NodePortWithOutIngress --set global.installType=public --set global.storageClassName=microk8s-hostpath --set global.cluster.provider=other --set-string global.gopaddle.https=false --set-string global.gopaddleWebhook.https=false --set global.staticIP=$STATICIP  --set global.gp-rabbitmq.enabled=false --set global.gp-lite-core.enabled=true --set gateway.gpkubeux.installSource=civo --version 4.2.2

sleep 2m
 
kubectl wait --for=condition=ready pod -l released-by=gopaddle -n gp-lite --timeout=20m

echo "access URL: http://$STATICIP:30003"