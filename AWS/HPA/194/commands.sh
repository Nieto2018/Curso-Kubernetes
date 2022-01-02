# Ejemplo de HPA
# Es necesario crear el metrics-server y luego desplegar el HPA

# Para desplegar el metrics-server:
# https://docs.aws.amazon.com/eks/latest/userguide/metrics-server.html
# Para desplegar el HPA:
# https://docs.aws.amazon.com/es_es/eks/latest/userguide/horizontal-pod-autoscaler.html

# Siguiendo el tutorial y la documentación obtenemos el error "Misconfigured Fargate Profile: fargate profile alb-test-cluster blocked for new launches due to: Failed to assume PodExecutionRole; Please make sure the role exists and trusts the eks-fargate-pods.amazonaws.com service principal"
# cuando corren los contenedores desplegados, para solucionar el error crear un namespace y crear todos los objetos en este.

kubectl delete ns test-hpa
kubectl autoscale deployment php-apache --cpu-percent=50 --min=1 --max=10 -n test-hpa
kubectl describe hpa -n test-hpa
kubectl run -n test-hpa -it --rm load-generator --image=busybox /bin/sh

# Comando para correr en el contenedor para estresar el HPA

kubectl get hpa -n test-hpa

kubectl delete ns test-hpa

kubectl delete deployment.apps/php-apache service/php-apache horizontalpodautoscaler.autoscaling/php-apache