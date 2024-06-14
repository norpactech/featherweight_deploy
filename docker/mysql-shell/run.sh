#!/bin/bash
mysqlsh -f /scripts/mysql-cluster.js
exec "$@"