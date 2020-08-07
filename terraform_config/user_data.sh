#!/usr/bin/env bash
sudo apt-get update
gpg --keyserver hkp://pool.sks-keyservers.net --recv-keys 409B6B1796C275462A1703113804BB82D39DC0E3 7D2BAF1CF37B13E2069D6956105BD0E739499BDB
curl -sSL https://get.rvm.io | bash
source ~/.rvm/scripts/rvm
rvm requirements
rvm install 2.4.1
rvm use 2.4.1 --default
gem install bundler
sudo apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv EA312927
echo "deb [ arch=amd64,arm64 ] https://repo.mongodb.org/apt/ubuntu bionic/mongodb-org/4.4 multiverse" | sudo tee /etc/apt/sources.list.d/mongodb-org-4.4.list
sudo apt-get update
sudo apt-get install -y mongodb
sudo systemctl start mongodb
sudo systemctl enable mongodb
cd ~/
mkdir reddit
cd reddit
git clone https://github.com/stasdevops/reddit_monolith.git
cd reddit_monolith
bundler install
puma -d
