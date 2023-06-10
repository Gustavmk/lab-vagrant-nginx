# configuração do HAPROXY

```bash

docker network create -d bridge dev
# WEB
docker rm -f nginxhost_1 ; docker run --rm -d --network=dev --name nginxhost_1 nginx-container
docker rm -f nginxhost_2 ; docker run --rm -d --network=dev --name nginxhost_2 nginx-container
docker rm -f nginxhost_3 ; docker run --rm -d --network=dev --name nginxhost_3 nginx-container

# Test HAPROXY cofig
docker run -it --network=dev --rm -v ${PWD}/haproxy:/usr/local/etc/haproxy:ro --name haproxy-syntax-check haproxy:2.7.8 haproxy -c -f /usr/local/etc/haproxy/haproxy.cfg

# PRE REQ
mkdir -p /run/haproxy && sudo chmod -R 777 /run/haproxy

# RUN HA PROXY
docker run --rm --network=dev -p 8404:8404 -p 80:80 -p 443:443 -v /run/haproxy:/run/haproxy:rw -v ${PWD}/haproxy:/usr/local/etc/haproxy:ro --name haproxy --sysctl net.ipv4.ip_unprivileged_port_start=0 haproxy:2.7.8

```
