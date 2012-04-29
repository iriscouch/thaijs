#!/usr/bin/env node
//
// Push the thaijs.com site.

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
