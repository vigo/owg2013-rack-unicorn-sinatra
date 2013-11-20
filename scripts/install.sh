#!/usr/bin/env bash

set -e

echo "Installing rbenv, ruby 1.9.3-p448 and related gems..."
source /home/vagrant/owg2013-rack-unicorn-sinatra/scripts/install_rbenv_ubuntu_12_04.sh

echo "Installing nginx and configuring needs..."
source /home/vagrant/owg2013-rack-unicorn-sinatra/scripts/install_nginx.sh

if [[ ! -e ~/.ackrc ]]; then
    sudo ln -s /home/vagrant/owg2013-rack-unicorn-sinatra/sinatra-nginx-unicorn/service.sh /etc/init.d/unicornd_my_unicorn_application
fi


sudo service unicornd_my_unicorn_application start
