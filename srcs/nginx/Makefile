KEY = /tmp/nginx.key
CERT = /tmp/nginx.crt

keys: 
	# yes "" | openssl req -x509 -nodes -days 365 -newkey rsa:2048 -keyout $(KEY) -out $(CERT) -subj "/CN=my-nginx/O=my-nginx"
	openssl req -x509 -nodes -days 365 -newkey rsa:2048 -keyout $(KEY) -out $(CERT) -subj "/CN=nginxsvc/O=nginxsvc"

clean:
	rm $(KEY)
	rm $(CERT)