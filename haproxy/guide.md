# configuração do HAPROXY

```bash
wget -v "http://www.haproxy.org/download/2.7/src/haproxy-2.7.8.tar.gz"
tar xvzf haproxy-2.7.8.tar.gz
cd haproxy-2.7.8
sudo apt-get install libz-dev libsystemd-dev build-essentials libpcre3 libpcre3-dev libssl-dev -y
make TARGET=linux-glibc USE_PCRE=1 USE_OPENSSL=1 USE_ZLIB=1 USE_CRYPT_H=1 USE_LIBCRYPT=1 USE_SYSTEMD=1

# Test HAPROXY config
docker run -it --rm -v ${PWD}/haproxy:/usr/local/etc/haproxy:ro --name haproxy-syntax-check haproxy:2.7.8 haproxy -c -f /usr/local/etc/haproxy/haproxy.cfg



docker network create -d bridge dev

docker run -d --rm --network=dev -p 8080:80 -v ${PWD}/haproxy:/usr/local/etc/haproxy:ro --name haproxy --sysctl net.ipv4.ip_unprivileged_port_start=0 haproxy:2.7.8


# WEb
docker run -d --rm --network=dev --name nginxhost_2 -p 8082:80 stenote/nginx-hostname
docker run -d --rm --network=dev --name nginxhost_3 -p 8083:80 stenote/nginx-hostname
docker run -d --rm --network=dev --name nginxhost_1 -p 8081:80 stenote/nginx-hostname
```
