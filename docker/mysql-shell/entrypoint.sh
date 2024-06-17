#!/bin/bash

printenv | grep 'MYSQL' > /etc/environment 
touch /var/log/cron.log
/usr/sbin/crond -m off && tail -f /var/log/cron.log