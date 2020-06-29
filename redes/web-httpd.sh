#!/bin/bash
export POD1=$(kubectl get po -o wide | grep httpd | grep node1 | awk -F" " '{print $1}')
export POD2=$(kubectl get po -o wide | grep httpd | grep node2 | awk -F" " '{print $1}')

echo 'HTTPD NODE 1 - LOAD BALANCER' > /tmp/index.html
kubectl cp /tmp/index.html $POD1:/usr/local/apache2/htdocs/

echo 'HTTPD NODE 2 - LOAD BALANCER' > /tmp/index.html
kubectl cp /tmp/index.html $POD2:/usr/local/apache2/htdocs/
