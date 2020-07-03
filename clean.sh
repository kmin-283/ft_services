make clean -C ./srcs/nginx

kubectl delete --all deployment
kubectl delete --all services
kubectl delete --all pod
kubectl delete --all secret
kubectl delete --all configmap
kubectl delete --all pv,pvc
minikube delete
docker rmi $(docker images -q) 