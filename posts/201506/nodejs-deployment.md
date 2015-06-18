# [Nodejs部署再思考](https://cnodejs.org/topic/557c55e916839d2d539362d8)
主要是文中引入了后面的几个文章链接

[Deploying Node.js with PM2 and Nginx](https://doesnotscale.com/deploying-node-js-with-pm2-and-nginx/)

## install nginx on ubuntu
```
sudo apt-get install python-software-properties #  Ubuntu <=12.04.xx
sudo apt-get install software-properties-common #  for >12.04
sudo add-apt-repository ppa:nginx/stable
sudo apt-get update
sudo apt-get install nginx
```

## config nginx

vim /etc/nginx/sites-enabled/your.domain.com.conf
```
server {
  server_name your.domain.com;
  listen 80;

  location / {
    proxy_set_header X-Real-IP $remote_addr;
    proxy_set_header X-Forwarded-For $proxy_add_x_forwarded_for;
    proxy_set_header Host $http_host;
    proxy_set_header X-NginX-Proxy true;
    proxy_pass http://127.0.0.1:3000;
    proxy_redirect off;
  }
}
```
sudo service nginx reload

"http://127.0.0.1:3000;" should be change to be your nodejs app's real port and ip


[NODEJS部署实践](http://nodeonly.com/2015/06/02/deploy.html)
mongodb的部署
安全 https://cnodejs.org/topic/54cdd026ef1b48510c27e07a
集群 http://www.linuxidc.com/Linux/2015-02/113296.htm
redis部署
http://www.linuxidc.com/Linux/2014-07/104306.htm

简单压测
apache ab
wrk
node cluster和nginx负载性能比较
todo

别人测试的node的性能稍高，不过我还是想自己测测

性能调优
todo

keeplive
http://www.bubuko.com/infodetail-260176.html
监控
newrelic https://cnodejs.org/topic/53fde58d7c1e2284785cd39e
资源
http://promotion.pm2.io/
https://github.com/Unitech/PM2
https://www.digitalocean.com/community/tutorials/how-to-use-pm2-to-setup-a-node-js-production-environment-on-an-ubuntu-vps

[nscale](https://github.com/nearform/nscale)
this stuff seems too complicated.


