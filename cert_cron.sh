#!/bin/bash

current_dir=$(dirname "$(realpath "$0")")

sudo certbot certificates > "$current_dir/info.log"
echo 'certificates info has already been updated'

sudo python3 "$current_dir/cert_renew.py"
echo 'python script has already executed'
