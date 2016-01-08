TelegramBot = require 'node-telegram-bot'
botJunction = require './functions/_parser'

subJunction = require './functions/xkcd'
botname = 'xkcdBot'

token = process.argv[2]

if not token
  console.log 'First argument must be bot token'
  process.exit()
  
botcmds = [
  'xkcd',
  'latest',
  'random',
  'relevant'
]

console.log botname + ' started...'

bot = new TelegramBot
  token: token

.on('message', (incoming) ->

  #console.log incoming

  if incoming.text

    incoming.bot = bot

    botJunction.junction incoming, botname, botcmds, subJunction

  )
  .start();
