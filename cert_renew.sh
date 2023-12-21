#!/bin/bash

current_dir=$(dirname "$(realpath "$0")")
config_file="$current_dir/cert-renew.conf"

source $config_file

sudo systemctl stop nginx
echo "stop nginx"

sudo certbot renew
echo "renew successfully"

for sub_domain in "${sub_domains[@]}"; do
    if [ "$sub_domain" = "main" ]; then
        sudo install -m 644 -o root -g root "/etc/letsencrypt/live/$main_domain/fullchain.pem" -t "$ssl_cert_path/$sub_domain"
        sudo install -m 644 -o root -g root "/etc/letsencrypt/live/$main_domain/privkey.pem" -t "$ssl_cert_path/$sub_domain"
        echo "install $main_domain's certification successfully"
    else
        sudo install -m 644 -o root -g root "/etc/letsencrypt/live/$sub_domain.$main_domain/fullchain.pem" -t "$ssl_cert_path/$sub_domain"
        sudo install -m 644 -o root -g root "/etc/letsencrypt/live/$sub_domain.$main_domain/privkey.pem" -t "$ssl_cert_path/$sub_domain"
        echo "install $sub_domain.$main_domain's certification successfully"
    fi
done

sudo systemctl restart nginx
echo "restart nginx successfully"

sudo systemctl restart xray
echo "restart xray successfully"
