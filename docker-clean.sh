#!/bin/sh

# Remove all pleo-antaeus images.
docker images --quiet --filter="reference=pleo-antaeus:*" | \
 while read image; do
   docker rmi -f "$image"
 done

# Optionally reclaim space of dangling images.
echo 'Run "docker system prune" to clear disk space?'
docker system prune
