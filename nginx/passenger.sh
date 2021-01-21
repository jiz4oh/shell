#!/bin/bash

echo 'installing dirmngr'
sudo apt-get install -y dirmngr -qq --no-install-recommends
echo 'installing gnupg'
sudo apt-get install -y gnupg -qq --no-install-recommends
sudo apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv-keys 561F9B9CAC40B2F7

echo 'installing apt-transport-https'
sudo apt-get install -y apt-transport-https -qq --no-install-recommends
echo 'installing ca-certificates'
sudo apt-get install -y ca-certificates -qq --no-install-recommends

echo 'installing lsb-release'
sudo apt-get install -y lsb-release -qq --no-install-recommends

echo 'add passenger source'
sudo sh -c 'echo deb https://oss-binaries.phusionpassenger.com/apt/passenger `lsb_release -cs` main > /etc/apt/sources.list.d/passenger.list'
sudo apt-get update

echo 'installing libnginx-mod-http-passenger'
sudo apt-get install -y libnginx-mod-http-passenger -qq --no-install-recommends

# check installation
sudo /usr/sbin/passenger-memory-stats
