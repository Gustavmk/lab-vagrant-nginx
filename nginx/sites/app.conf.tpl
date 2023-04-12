upstream {{ upstream_name }} {
    server 192.168.56.41:8080;
    server 192.168.56.42:8080;
    server 192.168.56.43:8080;
}

server {
    listen 80;
    listen [::]:80;
    server_name {{ site_name }};
    
    # logging
    access_log  /var/log/nginx/{{ site_name }}-access.log default;
    error_log /var/log/nginx/{{ site_name }}-error.log notice;
    
    # Buffer
    #proxy_buffering off;
    #proxy_request_buffering off;

    # Padroes definidos pela microsoft
    # https://docs.microsoft.com/en-us/aspnet/core/host-and-deploy/linux-nginx
    proxy_http_version 1.1;
    proxy_set_header   Upgrade $http_upgrade;
    proxy_set_header   Connection $http_connection;
    proxy_set_header   Host $host;
    proxy_cache_bypass $http_upgrade;
    proxy_set_header   X-Forwarded-For $proxy_add_x_forwarded_for;
    proxy_set_header   X-Forwarded-Proto $scheme;

    location / {
        proxy_pass "http://{{ upstream_name }}/";
        proxy_set_header X-Real-IP $remote_addr;
        proxy_set_header X-Forwarded-Host $host;
        proxy_set_header X-Forwarded-Port $server_port;
    }
    
}

