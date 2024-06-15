#!/bin/bash
mysqlsh -f /scripts/create-cluster.js
exec "$@"