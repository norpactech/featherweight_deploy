#!/bin/bash
mysqlsh -f /scripts/manage-cluster.js
exec "$@"