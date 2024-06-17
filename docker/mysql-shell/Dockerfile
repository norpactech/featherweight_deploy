# docker build -t norpac/mysql-shell .

FROM redhat/ubi8

ARG KEY=https://repo.mysql.com/RPM-GPG-KEY-mysql
ARG REPO=https://repo.mysql.com

ARG MYSQL_SHELL_PACKAGE_URL=$REPO/yum/mysql-tools-community/el/8/x86_64/mysql-shell-8.0.37-1.el8.x86_64.rpm

COPY entrypoint.sh /entrypoint.sh

RUN rpmkeys --import $KEY \
    && yum install -y \
    $MYSQL_SHELL_PACKAGE_URL \
    && yum install cronie -y \
    && yum clean all \
    && echo '* * * * * /scripts/manage-cluster.sh > /var/log/cron.log' > /etc/cron.d/cron \
    && chmod 0644 /etc/cron.d/cron \
    && crontab /etc/cron.d/cron \
    && chmod +x /entrypoint.sh 

CMD [ "/entrypoint.sh" ]