#!/bin/bash

#version test
version_code="1"
setting_file_version=$(sed -e "s/^##.*//g"  -e "/^$/d" setting.txt|grep version|head -n 1|sed s/.*://)
#if [ "x$setting_file_version" != "x$version_code" ];then
#        echo "setting.txt version error"
#        exit 1;
#fi;

cd $(dirname $0)
read -p "do you want to up this container ? (y/n):" yn
if [ ${yn,,} = "y" ]; then
	docker-compose up --build -d
fi
rm *.log
