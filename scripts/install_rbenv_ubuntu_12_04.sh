#!/usr/bin/env bash

set -e

if [[ `which rbenv` ]]; then
    exit 0
fi

sudo aptitude update
sudo aptitude install -y zlib1g-dev openssl libopenssl-ruby1.9.1 libssl-dev libruby1.9.1 libreadline-dev build-essential
if [[ ! `which git` ]]; then
    sudo aptitude install -y git-core
fi
cd
git clone git://github.com/sstephenson/rbenv.git .rbenv
echo 'export PATH="$HOME/.rbenv/bin:$PATH"' >> ~/.bashrc
echo 'eval "$(rbenv init -)"' >> ~/.bashrc

source ~/.bashrc

mkdir -p ~/.rbenv/plugins
cd ~/.rbenv/plugins
git clone git://github.com/sstephenson/ruby-build.git
rbenv install 1.9.3-p448
rbenv rehash

cd /home/vagrant/owg2013-rack-unicorn-sinatra/sinatra-nginx-unicorn/
gem install bundler
rbenv rehash
bundle install --path vendor/bundle --without development test
mkdir -p tmp/{sockets,pids,log}