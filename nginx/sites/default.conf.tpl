server {
    listen 8080 default;
    listen [::]:8080 default;

    server_name localhost;

    # logging
    access_log  /var/log/nginx/{{ site_name }}-access.log default;
    error_log /var/log/nginx/{{ site_name }}-error.log notice;
    
    # Buffer
    #proxy_buffering off;
    #proxy_request_buffering off;


    location / {
        root   /var/www/nginx-default;
        index  index.html index.htm;
    }

    location = /status {
        stub_status;
    }
    
}

