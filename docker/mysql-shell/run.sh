#!/bin/bash
# Note: There must be an easier way to pass environment variables to
#       mysqlsh. Hopefully, a better solution will become available.

# Temporary just for this run
cp /scripts/config.template /scripts/config.js

sed -i "s/{MYSQL_HOST_1}/$MYSQL_HOST_1/g" /scripts/config.js
sed -i "s/{MYSQL_HOST_2}/$MYSQL_HOST_2/g" /scripts/config.js
sed -i "s/{MYSQL_HOST_3}/$MYSQL_HOST_3/g" /scripts/config.js
sed -i "s/{MYSQL_PORT_1}/$MYSQL_PORT_1/g" /scripts/config.js
sed -i "s/{MYSQL_PORT_2}/$MYSQL_PORT_2/g" /scripts/config.js
sed -i "s/{MYSQL_PORT_3}/$MYSQL_PORT_3/g" /scripts/config.js
sed -i "s/{MYSQL_USERNAME}/$MYSQL_USERNAME/g" /scripts/config.js
sed -i "s/{MYSQL_PASSWORD}/$MYSQL_PASSWORD/g" /scripts/config.js

mysqlsh --js -f /scripts/manage-cluster.js

# Remove the username/password from the file system
rm /scripts/config.js

exec "$@"