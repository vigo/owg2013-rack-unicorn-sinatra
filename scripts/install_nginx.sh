#!/usr/bin/env bash

set -e

sudo aptitude install -y python-software-properties
sudo add-apt-repository ppa:nginx/stable
sudo aptitude update
sudo aptitude install -y nginx

sudo unlink /etc/nginx/sites-enabled/default

sudo ln -s /home/vagrant/owg2013-rack-unicorn-sinatra/sinatra-nginx-unicorn/nginx.conf /etc/nginx/sites-enabled/owg2104-demo-nginx.conf
sudo service nginx start
