# export MINIKUBE_HOME=~/goinfre
# echo "대쉬보드 설치"
# kubectl apply -f https://raw.githubusercontent.com/kubernetes/dashboard/v2.0.0/aio/deploy/recommended.yaml
# echo "대쉬보드 접근 토큰 생성"
# kubectl -n kubernetes-dashboard describe secret $(kubectl -n kubernetes-dashboard get secret | grep admin-user | awk '{print $1}')
# minikube를 사용하지 않는 경우에 위의 방법을 사용하여 대쉬보드를 설치할 수 있다.
# 그 후 kubectl proxy 라고 커맨드라인 창에 입력하고 발급된 토큰을 사용하여 대쉬보드에 접속한다.
# minikube를 사용하는 경우에는 단순하게 minikube dashboard 라고 커맨드라인 창에 입력하면 된다.

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

cd ./srcs/
echo -e "\033[47m\033[32m mysql image build \033[m"
docker build -t service-mysql ./mysql > /dev/null
echo -e "\033[47m\033[32m wordpress image build \033[m"
docker build -t service-wordpress ./wordpress > /dev/null
echo -e "\033[47m\033[32m phpmyadmin image build \033[m"
docker build -t service-phpmyadmin ./phpmyadmin > /dev/null
echo -e "\033[47m\033[32m nginx image build \033[m"
docker build -t service-nginx ./nginx > /dev/null
echo -e "\033[47m\033[32m ftps image build \033[m"
docker build -t service-ftps ./ftps > /dev/null
echo -e "\033[47m\033[32m telegraf image build \033[m"
docker build -t service-telegraf ./telegraf > /dev/null
echo -e "\033[47m\033[32m influxdb image build \033[m"
docker build -t service-influxdb ./influxdb > /dev/null
echo -e "\033[47m\033[32m grafana image build \033[m"
docker build -t service-grafana ./grafana > /dev/null
echo -e "\033[47m\033[32m 이미지 생성 완료 \033[m"

echo -e "\033[47m\033[32m mysql deployment 생성 \033[m"
kubectl apply -f ./mysql/mysql.yaml > /dev/null
echo -e "\033[47m\033[32m wordpress deployment 생성 \033[m"
kubectl apply -f ./wordpress/wordpress.yaml > /dev/null
echo -e "\033[47m\033[32m phpmyadmin deployment 생성 \033[m"
kubectl apply -f ./phpmyadmin/phpmyadmin.yaml > /dev/null
echo -e "\033[47m\033[32m nginx ssl secret 생성 \033[m"
kubectl apply -f ./nginx/nginxsecret.yaml > /dev/null
echo -e "\033[47m\033[32m nginx configmap 생성 \033[m"
kubectl create configmap nginxconfigmap --from-file=./nginx/default.conf --from-file=./nginx/proxy.conf > /dev/null
echo -e "\033[47m\033[32m nginx deployment 생성 \033[m"
kubectl apply -f ./nginx/nginx.yaml > /dev/null
echo -e "\033[47m\033[32m ftps deployment 생성 \033[m"
kubectl apply -f ./ftps/ftps.yaml > /dev/null
echo -e "\033[47m\033[32m influxdb deployment 생성 \033[m"
kubectl apply -f ./influxdb/influxdbconf.yaml > /dev/null
kubectl apply -f ./influxdb/influxdb.yaml > /dev/null
echo -e "\033[47m\033[32m telegraf deployment 생성 \033[m"
kubectl apply -f ./telegraf/telegrafconf.yaml > /dev/null
kubectl apply -f ./telegraf/telegraf.yaml > /dev/null
echo -e "\033[47m\033[32m grafana deployment 생성 \033[m"
kubectl apply -f ./grafana/grafana.yaml > /dev/null
echo -e "\033[47m\033[32m 모든 deployment 완료 \033[m"
sleep 3
echo "minikube dashboard 실행"
# minikube dashboard