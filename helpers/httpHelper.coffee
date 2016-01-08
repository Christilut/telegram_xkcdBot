http = require 'http'
https = require 'https'

module.exports =

  GET: (url, callback) ->

    if url.indexOf('https') == -1
      http.get url, (response) ->
        body = ''

        response.on 'data', (chunk) -> body += chunk
        response.on 'end', -> callback body
      .on 'error', (e) -> console.log 'GET error: ' + e
    else
      https.get url, (response) ->
        body = ''

        response.on 'data', (chunk) -> body += chunk
        response.on 'end', -> callback body
      .on 'error', (e) -> console.log 'GET error: ' + e
