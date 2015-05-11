#!/bin/bash
if [ "$#" -ne  "1" ]
  then
    echo "Please supply exactly one argument, the hash of the container."
    echo "The container's hash be found in the list below. If you can't find"
    echo "it, please create a dev container by running ./scripts/dev.sh"
    echo ""
    echo "Usage:"
    echo ""
    echo "For container xyz123, get a one-time login link by typing"
    echo ""
    echo "./scripts/uli.sh xyz123"
    docker ps
else
  docker exec $1 bash -c 'cd /srv/drupal/www && drush uli'
fi
