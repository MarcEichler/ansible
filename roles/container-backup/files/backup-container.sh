#!/bin/bash

set -e 

container=$1
backup_dir=/var/backup/$container
data_dir=$2

backup_file="$container-$(date +%F-%H%M%S).tar.lz4"

echo "### Executing backup for $container"
echo "Stopping container..."
docker stop "$container"

echo "Backing up to $backup_file"
docker run --rm --volumes-from "$container" -v "$backup_dir":/backup --name "$container-backup" container-backup bash -c "tar -I lz4 -cvf /backup/$backup_file $data_dir"

echo "Starting $container container..."
docker start "$container"

echo "Done"
