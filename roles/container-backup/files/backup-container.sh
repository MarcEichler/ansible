#!/bin/bash

set -e 

container=$1
backup_dir=/var/backup/$container
data_dir=$2

keep_short_max_age=7
keep_long_max_age=45

backup_file="$container-$(date +%F-%H%M%S).tar.lz4"

echo "### Executing backup for $container"
echo "Stopping container..."
docker stop "$container"

echo "Backing up to $backup_file"
docker run --rm --volumes-from "$container" -v "$backup_dir":/backup --name "$container-backup" container-backup bash -c "tar -I lz4 -cvf /backup/$backup_file $data_dir"

echo "Starting $container container..."
docker start "$container"

echo "Deleting backups older than $keep_short_max_age days..."
# Delete backups older than 7 days, unless they were created on monday
LC_TIME=C find "$backup_dir" -type f -mtime +$keep_short_max_age -exec sh -c 'test $(date +%a -r "$1") = Mon || rm "$1"' -- {} \;

# Delete all backups older than 45 days
echo "Deleting backups older than $keep_long_max_age days..."
find "$backup_dir" -type f -mtime +$keep_long_max_age -exec rm {}\;

echo "Done."
exit 0
