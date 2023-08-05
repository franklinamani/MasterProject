#!/bin/bash
if [[ "$(stat --file-system --format=%T /html)" == "nfs" ]]; then
  # Intial file-sync
  rsync -aq /html/ /var/www/html/ --delete-after
  rsync -aq /sql/  /var/www/sql/  --delete-after

  # sync files when changed
  kingsCS-filesync.sh "/html/" "/var/www/html/" &
  kingsCS-filesync.sh "/sql/" "/var/www/sql/" &
else
  # link /var/www/html to /html for non-NFS filesystems
  rmdir /var/www/sql &>/dev/null && \
  ln -s /sql /var/www/ &>/dev/null

  # link /var/www/html to /html for non-NFS filesystems
  rmdir /var/www/html &>/dev/null && \
  ln -s /html /var/www/ &>/dev/null && \
  cd /var/www/html
fi

# pass args to docker-entrypoint.sh
/usr/local/bin/docker-php-entrypoint "$@"