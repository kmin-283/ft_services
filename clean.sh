# make clean -C ./srcs/nginx

kubectl delete --all deployment
kubectl delete --all services
kubectl delete --all secret
kubectl delete --all configmap
kubectl delete --all pv,pvc
kubectl delete --all pod
# minikube delete
docker rmi $(docker images -q)
# docker rmi service-nginx service-wordpress service-mysql wordpress alpine yobasystems/alpine-mariadb