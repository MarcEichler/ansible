#!/bin/bash

set -e 

minecraft_container=minecraft
backup_dir=/var/backup/minecraft
minecraft_dir=/data

backup_name="minecraft-$(date +%F-%H%M%S).tar.gz"

echo "Stopping minecraft container..."
docker stop "$minecraft_container"

echo "Backing up to $backup_name"
docker run --rm --volumes-from "$minecraft_container" -v "$backup_dir":/backup --name "$minecraft_container-backup" ubuntu bash -c "tar cvzf /backup/$backup_name $minecraft_dir"

echo "Starting minecraft container..."
docker start "$minecraft_container"

echo "Done"
