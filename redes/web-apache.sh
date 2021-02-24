#!/bin/bash
export POD1=$(kubectl get po -o wide | grep apache | grep node1 | awk -F" " '{print $1}')
export POD2=$(kubectl get po -o wide | grep apache | grep node2 | awk -F" " '{print $1}')

echo 'APACHE NODE 1 - LOAD BALANCER' > /tmp/index.html
kubectl cp /tmp/index.html $POD1:/usr/local/apache2/htdocs/

echo 'APACHE NODE 2 - LOAD BALANCER' > /tmp/index.html
kubectl cp /tmp/index.html $POD2:/usr/local/apache2/htdocs/
