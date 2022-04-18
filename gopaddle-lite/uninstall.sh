#!/bin/bash

helm delete gp-rabbitmq-4-2  -n gp-lite

helm delete gp-core-4-2 -n gp-lite

kubectl delete ns gp-lite

if kubectl get ns gopaddle-servers >/dev/null 2>&1
then
kubectl delete ns gopaddle-servers

kubectl delete clusterrole gopaddle:prometheus-tool-kube-state-metrics gopaddle:prometheus-tool-server

kubectl delete clusterrolebinding gopaddle:event-exporter-rb gopaddle:prometheus-tool-kube-state-metrics gopaddle:prometheus-tool-server

kubectl delete service default-http-backend

kubectl delete deployment default-http-backend
fi