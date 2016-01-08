http = require 'http'
https = require 'https'
http.post = require 'http-post'

module.exports =

  GET: (url, callback) ->
    req = null
    if url.indexOf('https') == -1
      req = http.get url, (response) ->
        body = ''
        response.on 'data', (chunk) -> body += chunk
        response.on 'end', ->
          try
            json = JSON.parse body
            callback json
          catch ex
            return console.log ex

      .on 'error', (e) -> throw new Error 'GET error: ' + e + ', url: ' + JSON.stringify url

    else
      req = https.get url, (response) ->
        body = ''
        response.on 'data', (chunk) -> body += chunk
        response.on 'end', ->
          try
            json = JSON.parse body
            callback json
          catch ex
            return console.log ex
            
      .on 'error', (e) -> throw new Error 'GET error: ' + e + ', url: ' + JSON.stringify url

    req.setTimeout 10000, ->
      req.end()
      throw new Error('request timed out: ' + url)

  GETopts: (options, callback) ->
    req = null
    if options.https
      req = https.get options, (response) ->
          body = ''
          response.on 'data', (data) -> body += data
          response.on 'end', () ->
            try
              json = JSON.parse body
              callback json, response
            catch ex
              return console.log ex

      .on 'error', (e) -> throw new Error 'GET error: ' + e + ', url: ' + JSON.stringify options

    else
      req = http.get options, (response) ->
          body = ''
          response.on 'data', (data) -> body += data
          response.on 'end', () ->
            try
              json = JSON.parse body
              callback json
            catch ex
              return console.log ex

      .on 'error', (e) -> throw new Error 'GET error: ' + e + ', url: ' + JSON.stringify options


    req.setTimeout 10000, ->
      req.end()
      throw new Error('request timed out: ' + url)

  POST: (url, callback) ->
    req = http.post url, null, (response) ->
      body = ''
      response.on 'data', (chunk) -> body += chunk
      response.on 'end', -> callback JSON.parse body

    req.setTimeout 10000, ->
      req.end()
      throw new Error('request timed out: ' + url)
