#!/bin/bash
# Kubernetes directory
KUBE_DIR="kubernetes"
# Rabbit MQ helm config
RABBITMQ_NAME="my-rabbitmq"
RABBITMQ_USER="mueiya"
RABBITMQ_PASS="secretpassword"
RABBITMQ_COOKIE="secretcookie"
# Get the Minikube IP
export MINIKUBE_IP=$(minikube ip)

# Using helm for installing the rabbit mq
echo "Installing rabbit mq using helm..."
helm install $RABBITMQ_NAME --set auth.username=$RABBITMQ_USER,auth.password=$RABBITMQ_PASS,auth.erlangCookie=$RABBITMQ_COOKIE \ bitnami/rabbitmq
echo "rabbit mq username is $RABBITMQ_USER"
echo "rabbit mq password is $RABBITMQ_PASS"
echo "rabbit mq password is $RABBITMQ_COOKIE"


# Apply the namespace
echo "Applying the namespace..."
kubectl apply -f "$KUBE_DIR/namespace.yml"

# Apply the order-service
echo "Applying the order-service..."
kubectl apply -f "$KUBE_DIR/order/order-service.yml"
kubectl apply -f "$KUBE_DIR/order/order-gateway.yml"
kubectl apply -f "$KUBE_DIR/order/order-deployment.yml"

# Get the NodePort
export NODE_PORT_ORDER=$(kubectl get service -n ecommerce-app order-service -o jsonpath='{.spec.ports[0].nodePort}')

# Apply the shipping-service
echo "Applying the shipping-service..."
kubectl apply -f "$KUBE_DIR/shipping/shipping-service.yml"
kubectl apply -f "$KUBE_DIR/shipping/shipping-deployment.yml"

# Get the NodePort
export NODE_PORT_SHIPPING=$(kubectl get service -n ecommerce-app shipping-service -o jsonpath='{.spec.ports[0].nodePort}')

# Setting Up Istio
kubectl label namespace default istio-injection=enable

echo "Order-Service NodePort on http://$MINIKUBE_IP:$NODE_PORT_ORDER"
echo "Shipping-Service NodePort on http://$MINIKUBE_IP:$NODE_PORT_SHIPPING"
echo "Order-Service can be using istio"
