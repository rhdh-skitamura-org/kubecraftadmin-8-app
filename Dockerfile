FROM image-registry.openshift-image-registry.svc:5000/kubecraftadmin-8-develop/kcabuild:v1.0 AS build-go
ADD ./src/app/ /app/ 
WORKDIR /app
RUN go get -d
ENV CGO_ENABLED=0
RUN go build -o main . 

FROM alpine
RUN mkdir /app
RUN mkdir /.kube
WORKDIR /app
COPY --from=build-go /app/main /app/main
EXPOSE 8000/tcp
CMD ["/app/main"]
