#!/bin/bash

sudo certbot certificates > /path of your cert renew/info.log
echo 'certificates info has already been updated'

sudo python3 /path of your cert renew/cert_renew.py
echo 'python script has already executed'
