proxychains4 open -a Evernote



Install & Config:
step1. brew install proxychains-ng
step2. modify config file(/usr/local/Cellar/proxychains-ng/4.7/etc/proxychains.conf), add or modify: socks5 127.0.0.1 23333
PS: use your own local port to replace 23333

delete all content and replace
############proxychains.conf###########
strict_chain
quiet_mode
proxy_dns
remote_dns_subnet 224
tcp_read_time_out 15000
tcp_connect_time_out 8000
localnet 127.0.0.0/255.0.0.0

[ProxyList]
socks4  127.0.0.1 7072
socks5  127.0.0.1 7072
http    127.0.0.1 7072



#########Usage:
for example:
proxychains4 ping facebook.com
proxychains4 -q pip install shadowsocks