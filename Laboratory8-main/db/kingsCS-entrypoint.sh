#!/bin/bash
# Intial file-sync
rsync -aq /sql-initdb.d/ /docker-entrypoint-initdb.d/ --delete-after

# pass args to docker-entrypoint.sh
/usr/local/bin/docker-entrypoint.sh "$@"