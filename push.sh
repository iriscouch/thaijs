#!/bin/bash
#
# Push the thaijs.com site.

if ! which static+ ; then
  echo "Static+ not installed. Try npm -g install static-plus"
  exit 1
fi

if [ "$1" = "dev" ]; then
  couch="http://localhost:5984"
  domain="two.local"
elif [ -z "$pw" ]; then
  read -s -p "CouchDB password: " pw
  echo

  couch="https://jhs:$pw@jhs.iriscouch.com"
  domain="thaijs.com"
fi

while true; do
  static+ "$couch" thaijs "$domain"                             \
          --log=debug                                           \
          --prefix='' --staging-prefix='st.'                    \
          --seed="$PWD/seed" --publish="$PWD/publish"           \
          --watch

  echo "Restart"
  sleep 1
done
