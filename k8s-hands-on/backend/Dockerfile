# syntax=docker/dockerfile:1

# docker build -t k8s-hands-on:v1 .
# docker run --rm -it --name golang-backend -p 9090:9090 k8s-hands-on:v1

# minikube image build -t k8s-hands-on:v1 .

##
## Build
##
FROM golang:1.16-buster AS build

WORKDIR /app
COPY ./src/main.go .
RUN CGO_ENABLED=0 GOOS=linux GOPROXY=https://proxy.golang.org  go build -o app ./main.go

##
## Deploy
##
FROM alpine:latest

WORKDIR /app
COPY --from=build /app/app .
EXPOSE 9090
CMD ["./app"]