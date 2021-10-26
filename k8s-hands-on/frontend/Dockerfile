# docker build -t frontend-k8s-hands-on:v1 .
# docker run --rm -it --name golang-backend -p 80:80 frontend-k8s-hands-on:v1

# minikube image build -t frontend-k8s-hands-on:v1 .

##
## Build
##
FROM nginx:alpine

COPY ./src/index.html /usr/share/nginx/html/index.html