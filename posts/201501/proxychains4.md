proxychains4 open -a Evernote



Install & Config:
step1. brew install proxychains-ng
step2. modify config file(/usr/local/Cellar/proxychains-ng/4.7/etc/proxychains.conf), add or modify: socks5 127.0.0.1 23333
PS: use your own local port to replace 23333

Usage:
for example:
proxychains4 ping facebook.com
proxychains4 -q pip install shadowsocks