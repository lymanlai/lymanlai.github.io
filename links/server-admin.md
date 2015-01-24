[nginx && node with forever](https://cnodejs.org/topic/5059ce39fd37ea6b2f07e1a3)
[regex tool](http://tool.chinaz.com/regex/)




#setup the api.yaha
```
upstream socket_nodes {
    server localhost:8081;
}
server {
    server_name v2.api.yaha.me;
    location / {
        proxy_set_header Upgrade $http_upgrade;
        proxy_set_header Connection "upgrade";
        proxy_http_version 1.1;
        proxy_set_header X-Forwarded-For $proxy_add_x_forwarded_for;
        proxy_set_header Host $host;
        proxy_pass http://socket_nodes;
    }
}

server {
    server_name static.yaha.me;
    root /home/lyman/v2.api.yaha.me/upload;
    location / {
        rewrite "^(.*)/(\w{8})-(\w{4})-(\w{4})-(\w{4})-(\w{12})$" $1/$2/$3/$4/$5/$6 break;
        rewrite ^(.*)/(.*)$ $1/default.png break;
        expires max;
        #turn on to test, while all right turn then off
        #rewrite_log on;
        #error_log /var/log/nginx/v2.yaha.me-error.log notice;
    }
}
```