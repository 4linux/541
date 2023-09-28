#!/bin/bash

#### Helm Install
sudo chmod go-rw /home/suporte/.kube/config
sudo snap install helm --classic

#### Metallb Install
helm repo add bitnami https://charts.bitnami.com/bitnami
helm install metallb bitnami/metallb
kubectl apply -f /home/suporte/4541/cks/infra-setup/metallb-config.yaml

#### Nginx Ingress Install
helm repo add ingress-nginx https://kubernetes.github.io/ingress-nginx
helm install ingress-nginx ingress-nginx/ingress-nginx --version 3.34.0

### Deploy PHP 4Linux
kubectl apply -f /home/suporte/4541/cks/infra-setup/recursos.yaml
