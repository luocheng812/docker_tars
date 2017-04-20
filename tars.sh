#!/bin/bash

source /etc/profile

export export LANG="zh_CN.UTF-8"

# start core
cd /usr/local/app/tars

./tars_install.sh

# start web
/usr/local/resin/bin/resin.sh start
