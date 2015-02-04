server {
    resolver 8.8.8.8;
    resolver_timeout 5s;

    listen 0.0.0.0:8081;

    access_log  /home/lyman/gfw_proxy/access.log;
    error_log  /home/lyman/gfw_proxy/error.log;

    location / {
        proxy_pass $scheme://$host$request_uri;
        proxy_set_header Host $http_host;

        proxy_buffers 256 4k;
        proxy_max_temp_file_size 0;

        proxy_connect_timeout 30;

        proxy_cache_valid 200 302 10m;
        proxy_cache_valid 301 1h;
        proxy_cache_valid any 1m;
    }
}

#http://www.cnblogs.com/inteliot/archive/2013/01/11/2855907.html
#scp nginx-gfw-proxy.md li400-171:~/gfw_proxy/nginx.conf