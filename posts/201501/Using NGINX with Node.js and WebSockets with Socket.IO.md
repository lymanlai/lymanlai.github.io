[source](http://nginx.com/blog/nginx-nodejs-websockets-socketio/)

#What Is Socket.IO?
 it makes building realtime apps, like online games or chat, simple. Since version 1.3.13, NGINX supports proxying of WebSocket connections, which allows you to utilize socket.IO.
 ##Why Use NGINX for Node.js and Socket.IO?
 When your application is in production it likely needs to be running on port 80, 443, or both. This can be a challenge if you have several components of your application that interact with your user or are using a webserver on port 80 to deliver other assets. This makes it necessary to proxy to the socket.IO server, and NGINX is the best way to do that. Whether your backend application has one instance or hundreds, NGINX can also load balance your upstreams when using multiple nodes.

 #Socket.IO Configuration
#NGINX Configuration
1. Upstream Declaration
```
upstream socket_nodes {
  ip_hash;
  server srv1.app.com:5000 weight=5;
  server srv2.app.com:5000;
  server srv3.app.com:5000;
  server srv4.app.com:5000;
}
upstream socket_nodes {
  server localhost:8081;
}
```
2. Virtual Host Configuration
Since the WebSocket protocol uses the upgrade header, we need to tell NGINX use to use HTTP v1.1.
```
server {
  server_name app.domain.com;
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
```
3. What About Static Files?
```
location /assets {
    alias /path/to/assets;
    access_log off;
    expires max;
}
server {
  server_name static.yaha.me;
  location / {
    alias /home/lyman/v2.api.yaha.me/upload;
    access_log off;
    expires max;
  }
}
```
4. Possible Errors:
f you receive the below error you are likely running a version of NGINX prior to 1.3. In order to use WebSockets with NGINX you will need version 1.3.13 or later.
```
WebSocket connection to '...' failed: Error during WebSocket handshake:
'Connection' header value is not 'Upgrade': keep-alive socket.io.js:2371
```
