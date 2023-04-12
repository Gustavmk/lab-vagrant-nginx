user www-data;
worker_processes 8;
worker_rlimit_nofile 20000;
pid /run/nginx.pid;
include /etc/nginx/modules-enabled/*.conf;

events {
        worker_connections 10000;
        multi_accept on;
}

http {
        # Basic Settings
        sendfile                        on;
        tcp_nopush                      on;
        tcp_nodelay                     on;
        client_max_body_size            100M;

        ### Configurações de TIMEOUT ###
        keepalive_timeout               60s;
        keepalive_requests              100;
        send_timeout                    30s;
        types_hash_max_size             2048;
        server_tokens                   off;
        server_names_hash_bucket_size   512;
        server_name_in_redirect         off;

        ## Configurações de timeout com a upstream
        proxy_read_timeout              1200s; 
#       proxy_connect_timeout           300s;
#       proxy_send_timeout              300s;

        ## Configurações de Buffer com a upstream
        proxy_buffers                   16 16k;
        proxy_buffer_size               16k;
        proxy_busy_buffers_size         16k;
        proxy_max_temp_file_size        20M;
        
        include /etc/nginx/mime.types;
        default_type application/octet-stream;

        # SSL Settings
        ssl_protocols                   TLSv1.2; 
        ssl_prefer_server_ciphers       on;

        # Gzip Settings
        gzip                    on;
        gzip_vary               on;
        gzip_proxied            off;
        gzip_comp_level         5;
        gzip_min_length         1000;
        gzip_buffers            16 8k;
        gzip_http_version       1.1;
        gzip_disable            "msie6";
        gzip_types              text/plain text/css application/json application/javascript text/xml application/xml application/xml+rss text/javascript;


        # Prevent flood
        limit_conn_zone $binary_remote_addr zone=conn_limit_per_ip:10m;
        limit_req_zone $binary_remote_addr zone=req_limit_per_ip:10m rate=5r/s;
        

        # Expires default config 
        map $sent_http_content_type $expires {
            default                    off;
            text/html                  epoch;
            text/css                   max;
            application/javascript     max;
            ~image/                    max;
        }

        #expires $expires;

        # Virtual Host Configs and Logging settings
        include /etc/nginx/conf.d/*.conf;
        include /etc/nginx/sites-enabled/*.conf;
}