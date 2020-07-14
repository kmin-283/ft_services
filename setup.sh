# echo "대쉬보드 설치"
# kubectl apply -f https://raw.githubusercontent.com/kubernetes/dashboard/v2.0.0/aio/deploy/recommended.yaml
# echo "대쉬보드 접근 토큰 생성"
# kubectl -n kubernetes-dashboard describe secret $(kubectl -n kubernetes-dashboard get secret | grep admin-user | awk '{print $1}')

# echo "metallb설치"
# kubectl get configmap kube-proxy -n kube-system -o yaml | \
# sed -e "s/strictARP: false/strictARP: true/" | \
# kubectl diff -f - -n kube-system
# kubectl get configmap kube-proxy -n kube-system -o yaml | \
# sed -e "s/strictARP: false/strictARP: true/" | \
# kubectl apply -f - -n kube-system
# kubectl apply -f https://raw.githubusercontent.com/metallb/metallb/v0.9.3/manifests/namespace.yaml
# kubectl apply -f https://raw.githubusercontent.com/metallb/metallb/v0.9.3/manifests/metallb.yaml
# kubectl create secret generic -n metallb-system memberlist --from-literal=secretkey="$(openssl rand -base64 128)"
# kubectl apply -f metallb-config.yaml

# echo "local image 사용가능하게 하기"
eval $(minikube docker-env)

# echo "ssl키 생성"
# # make keys

cd ./srcs/
echo "mysql image build"
docker build -t service-mysql ./mysql > /dev/null
echo "wordpress image build"
docker build -t service-wordpress ./wordpress > /dev/null
echo "phpmyadmin image build"
docker build -t service-phpmyadmin ./phpmyadmin > /dev/null
echo "nginx image build"
docker build -t service-nginx ./nginx > /dev/null
echo "ftps image build"
docker build -t service-ftps ./ftps
echo "이미지 생성 완료"

echo "mysql secret 생성"
kubectl apply -f ./mysql/mysqlpw.yaml > /dev/null
echo "mysql deployment 생성"
kubectl apply -f ./mysql/mysql.yaml > /dev/null
echo "wordpress deployment 생성"
kubectl apply -f ./wordpress/wordpress.yaml > /dev/null
echo "phpmyadmin deployment 생성"
kubectl apply -f ./phpmyadmin/phpmyadmin.yaml > /dev/null
echo "nginx ssl secret 생성"
kubectl apply -f ./nginx/nginxsecret.yaml > /dev/null
echo "nginx configmap 생성"
kubectl create configmap nginxconfigmap --from-file=./nginx/default.conf --from-file=./nginx/proxy.conf > /dev/null
echo "nginx deployment 생성"
kubectl apply -f ./nginx/nginx.yaml > /dev/null
echo "ftps deployment 생성"
kubectl apply -f ./ftps/ftps.yaml