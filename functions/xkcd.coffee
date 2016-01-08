jsonHelper = require '../helpers/jsonHelper'
httpHelper = require '../helpers/httpHelper'
telegram = require './_telegram'

lastxkcd = 1626 # TODO get max from somewhere and not hardcode it...

module.exports =

  junction: (incoming, cmd) ->

    if cmd.indexOf('xkcd') == 0 then cmd = cmd.substring('xkcd'.length).trim()

    if not cmd then cmd = 'random'

    subcmd = cmd.split(' ')[0]

    switch subcmd
      when 'random'
        xkcdRandom(incoming)
      when 'newest', 'latest', 'new', 'last', 'current'
        xkcdLatest(incoming)
      when 'relevant'
        xkcdRelevant(incoming, cmd)
      when 'help', 'start', '?'
        xkcdHelp(incoming)
      when 'settings'
        xkcdSettings incoming
      else
        if not isNaN(subcmd)
          xkcdById(incoming, subcmd)
        else
          console.log 'invalid xkcd command: ' + cmd

xkcdMessage = (incoming, xkcd_json) ->
  telegram.textMessageWithPreview incoming,
  xkcd_json.img + '\nxkcd number: ' + xkcd_json.num + '\nTitle: ' + xkcd_json.title + '\nAlt text: ' + xkcd_json.alt

xkcdRandom = (incoming) ->
  randomxkcd = Math.floor((Math.random() * (lastxkcd - 1)) + 1)
  if randomxkcd == 404 then randomxkcd = 405 # 404 is missing, real funny...
  console.log 'random xkcd requested: ' + randomxkcd

  jsonHelper.GET 'http://xkcd.com/' + randomxkcd + '/info.0.json', (json) ->
    xkcdMessage incoming, json

xkcdLatest = (incoming) ->
  console.log 'latest xkcd requested'
  jsonHelper.GET 'http://xkcd.com/info.0.json', (json) ->
    xkcdMessage incoming, json

    lastxkcd = parseInt json.num
    console.log 'last xkcd updated: ' + lastxkcd

xkcdById = (incoming, id) ->
  console.log 'specific xkcd requested: ' + id
  xkcdId = parseInt id
  if lastxkcd > xkcdId > 0 and xkcdId != 404
    jsonHelper.GET 'http://xkcd.com/' + id + '/info.0.json', (json) ->
      xkcdMessage incoming, json
  else
    telegram.textMessage incoming, 'Sorry, that xkcd does not exist...'
    console.log 'ignored invalid xkcd number: ' + id

xkcdRelevant = (incoming, cmd) ->
  search = cmd.substring('relevant'.length).trim()

  if not search
    return xkcdHelp incoming

  console.log 'relevant xkcd requested: ' + search

  if search.indexOf('horse') != -1 and search.indexOf('battery') != -1 # since this is searched alot and is parsed wrong, we just fix it like this... its a popular xkcd...
    jsonHelper.GET 'http://xkcd.com/936/info.0.json', (json) ->
      xkcdMessage incoming, json
    return

  if search
    httpHelper.GET 'http://relevantxkcd.appspot.com/process?action=xkcd&query=' + search, (response) ->
      split = response.split '\n'

      id = split[2].split(' ')[0]

      xkcdById incoming, id

xkcdSettings = (incoming) ->
  console.log 'xkcd settings requested'

  telegram.textMessage incoming, 'No settings are available.'

xkcdHelp = (incoming) ->
  console.log 'xkcd help requested'

  telegram.textMessage incoming,
  'xkcd\n\n
  The following subcommands are available:\n
  - random\n
  - latest\n
  - relevant {text}\n
  - 1337 (or any number)\n\n

  Example commands:\n ' +
  incoming.botname + ' xkcd relevant ballmer peak\n ' +
  incoming.botname + ' xkcd 1000'
