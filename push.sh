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

var fs = require('fs')
var SP = require('static-plus')

if(require.main === module)
  main()

function main() {
  var DB = process.argv[2] || process.env.db
  if(!DB)
    return console.error('Usage: build.js <database_url>')

  var builder = new SP.Builder
  builder.target = DB + '/thaijs'
  builder.read_only = true

  // The landing page and (generated) Javascript is static attachments.
  var land = [ '<html>'
             ,   '<body>'
             ,     '<p>Thai JS</p>'
             ,   '</body>'
             , '</html>'
             ].join('')

  builder.page('', land, 'text/html')

  builder.deploy()
  builder.on('deploy', function(result) {
    console.log('Deployed: %s/%s/', result.url, builder.namespace)
  })
}
