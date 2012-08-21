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
  pro="www."
  staging=""
elif [ -z "$pw" ]; then
  read -s -p "CouchDB password: " pw
  echo

  couch="https://jhs:$pw@jhs.iriscouch.com"
  domain="thaijs.com"
  pro=""
  staging="staging."
fi

while true; do
  static+ "$couch" thaijs "$domain"                             \
          --log=debug                                           \
          --prefix="$pro" --staging-prefix="$staging"           \
          --seed="$PWD/seed" --publish="$PWD/publish"           \
          --watch

  echo "Restart"
  sleep 1
done
