#!/bin/bash
cd ~/
mkdir reddit
cd reddit
git clone https://github.com/stasdevops/reddit_monolith.git
cd reddit_monolith
bundler install
puma -d