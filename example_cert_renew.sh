#!/bin/bash

main_domain='example.com'

sudo systemctl stop nginx
echo "stop nginx"

sudo certbot renew
echo "renew successfully"

sudo install -m 644 -o leaf -g leaf "/etc/letsencrypt/live/$main_domain/fullchain.pem" -t /path of your ssl cert
sudo install -m 644 -o leaf -g leaf "/etc/letsencrypt/live/$main_domain/privkey.pem" -t /path of your ssl cert
echo "install certification successfully"

sudo systemctl restart nginx
echo "restart nginx successfully"

sudo systemctl restart xray
echo "restart xray successfully"
