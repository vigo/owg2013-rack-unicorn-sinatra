#!/usr/bin/env bash

set -e

sudo aptitude update
sudo aptitude install -y zlib1g-dev openssl libopenssl-ruby1.9.1 libssl-dev libruby1.9.1 libreadline-dev build-essential
if [[ ! `which git` ]]; then
  sudo aptitude install -y git-core
fi
cd
git clone git://github.com/sstephenson/rbenv.git .rbenv
echo 'export PATH="$HOME/.rbenv/bin:$PATH"' >> ~/.bashrc
mkdir -p ~/.rbenv/plugins
cd ~/.rbenv/plugins
git clone git://github.com/sstephenson/ruby-build.git
rbenv install 1.9.3-p448
rbenv rehash
gem install bundler
rbenv rehash