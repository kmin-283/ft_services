# 클러스터 만들기

# gcloud container clusters create kmin-cluster --num-nodes=3 --machine-type=n1-standard-2 --zone asia-northeast2-a 
# 디스크만들기

# gcloud compute disks create pv-kmin-disk --size 10GB --zone asia-northeast2-a


#Dockerfile 이미지 만들기

docker build -t service_nginx ./srcs/nginx
docker build -t service_influxdb ./srcs/influxdb
