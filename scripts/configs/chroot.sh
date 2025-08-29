#!/bin/bash

echo 'openeuler' | passwd --stdin root
echo openEuler > /etc/hostname
ln -s /usr/share/zoneinfo/Asia/Shanghai /etc/localtime
chkconfig --add extend-root.sh
chkconfig extend-root.sh on