#!/bin/bash
# prevent debconf from trying to open stdin
export DEBIAN_FRONTEND=noninteractive

curl -sSL https://rvm.io/pkuczynski.asc | gpg --import -
curl -sSL https://get.rvm.io | bash -s stable

mkdir -p ~/.rvm/user
echo "ruby_url=https://cache.ruby-china.com/pub/ruby" > ~/.rvm/user/db

source /home/vagrant/.rvm/scripts/rvm

rvm use --default --install --disable-binary $1

gem sources --add https://gems.ruby-china.com --remove https://rubygems.org/
gem install bundler
bundle config mirror.https://rubygems.org https://gems.ruby-china.com

shift

if (( $# ))
then gem install $@
fi

rvm cleanup all
